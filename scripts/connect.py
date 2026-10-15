#!/usr/bin/env python3
"""Install ContentFactory for Codex or Claude Code with one native OAuth flow."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import shutil
import stat
import subprocess
import sys
from urllib.error import HTTPError, URLError
from urllib.parse import urlsplit
from urllib.request import HTTPRedirectHandler, Request, build_opener


ENDPOINT = "https://content-factory.art/mcp"
DISCOVERY = "https://content-factory.art/.well-known/oauth-protected-resource/mcp"
SERVER_NAME = "content-factory"
SKILL_NAME = "contentfactory-video"
# Public OAuth metadata is small; bound an unexpected response before JSON decoding.
MAX_METADATA_BYTES = 64 * 1024
MESSAGES = {
    "en": {
        "plan": "Skill destination: {path}",
        "endpoint": "MCP endpoint: " + ENDPOINT,
        "dry": "Dry run: no files, network requests, configuration changes or OAuth login.",
        "existing": "Existing ContentFactory connection retained. No add or login was run.",
        "browser": "Complete the native Codex sign-in in your browser. Select projects, permissions and lifetime. If no browser opens, press Ctrl+C and use the manual recovery in docs/en.md.",
        "installed": "ContentFactory skill installed. Reload your workspace skills in Codex.",
        "ready": "Use $contentfactory-video in your preferred language. Authentication is verified by your next MCP call.",
        "failed": "Setup stopped: {reason}",
        "interrupted": "Setup interrupted. An added server or installed skill may remain; retry safely or use --login after a confirmed authentication failure.",
        "workspace": "--workspace must identify an existing directory.",
        "links": "Symbolic links and directory junctions are not supported in installation paths.",
        "source": "The bundled skill is incomplete or contains an unsupported entry.",
        "conflict": "The destination contains different or additional files. Preserve your edits and choose another workspace; nothing was overwritten.",
        "cli": "Codex CLI was not found. Install the official Codex CLI, then repeat this command.",
        "cli_version": "This Codex CLI lacks the documented OAuth registration options. Update the official CLI before connecting.",
        "config": "Codex could not safely describe this named connection. Inspect it through your client's MCP settings; raw configuration was not printed.",
        "different": "The named server already exists with a different endpoint, disabled state or custom authentication. No connection was changed. Review it in Codex settings.",
        "metadata": "The unified ContentFactory endpoint is not available or its OAuth discovery is incompatible. No connection was added. Retry after the server release or use --install-only to install instructions.",
        "oauth": "The native Codex OAuth command did not complete. A server entry may remain. Follow its terminal instructions and retry with --login. Do not paste sign-in URLs into chat.",
        "storage": "The skill could not be installed. Check destination permissions; a partial installation can be retried without overwriting existing files.",
    },
    "ru": {
        "plan": "Папка скилла: {path}",
        "endpoint": "Адрес MCP: " + ENDPOINT,
        "dry": "Предпросмотр: файлы, сеть, настройки и OAuth не изменяются.",
        "existing": "Существующее подключение сохранено. Добавление сервера и повторный вход не запускались.",
        "browser": "Завершите вход Codex в браузере. Выберите проекты, права и срок доступа. Если браузер не открылся, нажмите Ctrl+C и выполните ручное восстановление из docs/ru.md.",
        "installed": "Скилл ContentFactory установлен. Обновите список скиллов проекта в Codex.",
        "ready": "Используйте $contentfactory-video на удобном языке. Следующий вызов MCP проверит авторизацию.",
        "failed": "Установка остановлена: {reason}",
        "interrupted": "Установка прервана. Добавленный сервер или скилл могли сохраниться; повторите команду, а после подтвержденной ошибки авторизации используйте --login.",
        "workspace": "--workspace должен указывать на существующую папку.",
        "links": "Символические ссылки и соединения каталогов не поддерживаются в путях установки.",
        "source": "В комплекте отсутствует часть скилла или обнаружен неподдерживаемый файл.",
        "conflict": "В целевой папке есть отличающиеся или дополнительные файлы. Сохраните свои правки и выберите другой проект; существующие файлы не перезаписаны.",
        "cli": "Codex CLI не найден. Установите официальный Codex CLI и повторите команду.",
        "cli_version": "Версия Codex CLI не поддерживает указанные настройки OAuth. Обновите официальный CLI.",
        "config": "Codex не смог безопасно описать это подключение. Проверьте его в настройках MCP; исходная конфигурация не выводилась.",
        "different": "Сервер с таким именем имеет другой адрес, отключен или использует особую авторизацию. Настройки не изменены. Проверьте подключение в Codex.",
        "metadata": "Единый MCP ContentFactory пока недоступен или его OAuth-метаданные несовместимы. Подключение не добавлено. Повторите после обновления сервера либо установите только скилл с --install-only.",
        "oauth": "Вход через Codex не завершен. Запись сервера могла сохраниться. Следуйте инструкциям клиента в терминале и повторите с --login. Не отправляйте ссылки авторизации в чат.",
        "storage": "Не удалось установить скилл. Проверьте права на папку; частичную установку можно повторить без перезаписи файлов.",
    },
}


class SetupError(Exception):
    """A localized, non-secret diagnostic key."""


class NoRedirects(HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def reject_links(path: Path) -> None:
    for item in (*reversed(path.parents), path):
        try:
            info = item.lstat()
        except FileNotFoundError:
            continue
        reparse = getattr(info, "st_file_attributes", 0) & getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0)
        if stat.S_ISLNK(info.st_mode) or reparse:
            raise SetupError("links")


def installation_plan(workspace: Path, source: Path, client: str = "codex") -> tuple[Path, dict[Path, bytes]]:
    reject_links(workspace)
    if not workspace.is_dir():
        raise SetupError("workspace")
    reject_links(source)
    if not (source / "SKILL.md").is_file():
        raise SetupError("source")
    files: dict[Path, bytes] = {}
    for item in sorted(source.rglob("*")):
        reject_links(item)
        if item.is_file():
            files[item.relative_to(source)] = item.read_bytes()
        elif not item.is_dir():
            raise SetupError("source")
    destination = workspace / (".claude" if client == "claude" else ".agents") / "skills" / SKILL_NAME
    reject_links(destination)
    if destination.exists():
        if not destination.is_dir():
            raise SetupError("conflict")
        for item in destination.rglob("*"):
            reject_links(item)
            if item.is_file():
                relative = item.relative_to(destination)
                if relative not in files or item.read_bytes() != files[relative]:
                    raise SetupError("conflict")
            elif not item.is_dir():
                raise SetupError("conflict")
    for relative in files:
        target = destination / relative
        if target.exists() and not target.is_file():
            raise SetupError("conflict")
    return destination, files


def install(destination: Path, files: dict[Path, bytes]) -> None:
    try:
        for relative, content in files.items():
            target = destination / relative
            reject_links(target)
            target.parent.mkdir(parents=True, exist_ok=True)
            if target.exists():
                if not target.is_file() or target.read_bytes() != content:
                    raise SetupError("conflict")
                continue
            with target.open("xb") as handle:
                handle.write(content)
    except OSError as exc:
        raise SetupError("storage") from exc


def metadata_valid(document: object) -> bool:
    if not isinstance(document, dict) or document.get("resource") != ENDPOINT:
        return False
    issuers = document.get("authorization_servers")
    if not isinstance(issuers, list) or not issuers:
        return False
    for issuer in issuers:
        if not isinstance(issuer, str):
            return False
        try:
            parsed = urlsplit(issuer)
            if (parsed.scheme != "https" or parsed.netloc != "content-factory.art"
                    or parsed.query or parsed.fragment):
                return False
        except ValueError:
            return False
    return True


def check_discovery() -> None:
    request = Request(DISCOVERY, headers={"Accept": "application/json"})
    try:
        with build_opener(NoRedirects()).open(request, timeout=15) as response:
            data = response.read(MAX_METADATA_BYTES + 1)
            if len(data) > MAX_METADATA_BYTES or not metadata_valid(json.loads(data)):
                raise SetupError("metadata")
    except (HTTPError, URLError, OSError, ValueError) as exc:
        raise SetupError("metadata") from exc


def run_cli(command: list[str], workspace: Path, *, interactive: bool = False):
    # Only OAuth inherits the user's terminal, including its manual callback prompt.
    # Configuration diagnostics stay captured and never enter helper output.
    try:
        return subprocess.run(command, cwd=workspace, capture_output=not interactive,
                              text=True, encoding="utf-8", errors="replace",
                              timeout=None if interactive else 15, check=False)
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise SetupError("oauth" if interactive else "config") from exc


def claude_connection_exists(cli: str, workspace: Path) -> bool:
    result = run_cli([cli, "mcp", "get", SERVER_NAME], workspace)
    if result.returncode:
        expected = f'No MCP server named "{SERVER_NAME}". Run `claude mcp add` to add one.'
        if not result.stdout.strip() and result.stderr.strip() == expected:
            return False
        raise SetupError("config")
    # Claude currently exposes text, not JSON. Fail closed if its format changes.
    lines = [line.strip() for line in result.stdout.splitlines() if line.strip()]
    fields = {}
    for line in lines:
        if line == SERVER_NAME + ":" or line.startswith("To remove this server, run: "):
            continue
        key, separator, value = line.partition(": ")
        if not separator or key not in {"Scope", "Status", "Issue", "Type", "URL"} or key in fields:
            raise SetupError("different")
        fields[key] = value
    if (not lines or lines[0] != SERVER_NAME + ":" or fields.get("Type") != "http"
            or fields.get("URL") != ENDPOINT or not fields.get("Scope")
            or not fields.get("Status") or "disabled" in fields["Status"].lower()):
        raise SetupError("different")
    return True


def connection_exists(cli: str, workspace: Path, client: str = "codex") -> bool:
    if client == "claude":
        return claude_connection_exists(cli, workspace)
    result = run_cli([cli, "mcp", "get", SERVER_NAME, "--json"], workspace)
    if result.returncode:
        expected = f"Error: No MCP server named '{SERVER_NAME}' found."
        lines = result.stderr.strip().splitlines()
        # Codex may emit this harmless warning for an isolated/temporary home.
        # Other diagnostics must not be mistaken for an absent server.
        alias_warning = "WARNING: proceeding, even though we could not create PATH aliases:"
        if (not result.stdout.strip() and lines and lines[-1] == expected
                and all(line.startswith(alias_warning) for line in lines[:-1])):
            return False
        raise SetupError("config")
    try:
        config = json.loads(result.stdout)
        transport = config.get("transport", {})
        compatible = (config.get("name") == SERVER_NAME and config.get("enabled") is True
                      and isinstance(transport, dict)
                      and transport.get("type") == "streamable_http"
                      and transport.get("url") == ENDPOINT
                      and not any(transport.get(key) for key in (
                          "bearer_token_env_var", "http_headers", "env_http_headers",
                          "http_headers_helper")))
    except (ValueError, AttributeError):
        raise SetupError("config") from None
    if not compatible:
        raise SetupError("different")
    return True


def oauth_command(cli: str, *, existing: bool, client: str = "codex") -> list[str]:
    if client == "claude":
        if existing:
            return [cli, "mcp", "login", SERVER_NAME]
        return [cli, "mcp", "add", "--transport", "http", "--scope", "local", SERVER_NAME, ENDPOINT]
    if existing:
        return [cli, "mcp", "login", SERVER_NAME, "--oauth-client-registration", "dcr"]
    return [cli, "mcp", "add", SERVER_NAME, "--url", ENDPOINT,
            "--oauth-client-registration", "dcr", "--oauth-resource", ENDPOINT]


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--client", choices=("codex", "claude"), default="codex")
    parser.add_argument("--workspace", type=Path, required=True,
                        help="existing workspace where the self-contained skill is installed")
    parser.add_argument("--language", choices=tuple(MESSAGES), default="en")
    parser.add_argument("--dry-run", action="store_true", help="show the plan without reads of client config, writes or network")
    parser.add_argument("--install-only", action="store_true", help="install instructions without accessing the client or network")
    parser.add_argument("--login", action="store_true", help="explicitly sign in again for an existing verified connection")
    parser.add_argument("--check", action="store_true", help="check public OAuth discovery only; no installation, client access or login")
    parser.add_argument("--no-browser", action="store_true", help="let the native client show its manual sign-in flow in your terminal")
    args = parser.parse_args(argv)
    if args.install_only and args.login:
        parser.error("--install-only and --login cannot be combined")
    if args.check and (args.install_only or args.login or args.no_browser):
        parser.error("--check cannot be combined with installation or login options")
    messages = dict(MESSAGES[args.language])
    client_name = "Claude Code" if args.client == "claude" else "Codex"
    invocation = "/contentfactory-video" if args.client == "claude" else "$contentfactory-video"
    if args.client == "claude":
        messages = {key: value.replace("Codex", client_name).replace("$contentfactory-video", invocation)
                    for key, value in messages.items()}
    messages["browser"] = ("Complete one ContentFactory authorization in the native client. Select projects, permissions and lifetime."
                           if args.language == "en" else "Завершите одну авторизацию ContentFactory в клиенте. Выберите проекты, права и срок доступа.")
    messages["cli_version"] = (f"Update the official {client_name} CLI; its native MCP login options are required."
                               if args.language == "en" else f"Обновите официальный {client_name} CLI: нужны команды входа в MCP.")
    messages["manual_add"] = ("Codex add does not support --no-browser. Run setup without it first; if the browser cannot open, interrupt and retry with --login --no-browser."
                              if args.language == "en" else "Codex add не поддерживает --no-browser. Сначала запустите без флага; если браузер не открывается, прервите и повторите с --login --no-browser.")
    source = Path(__file__).resolve().parents[1] / "skills" / SKILL_NAME
    workspace = Path(args.workspace.expanduser().absolute())
    try:
        if args.check:
            if args.dry_run:
                print(messages["dry"])
            else:
                check_discovery()
                print(("Public OAuth discovery OK: " if args.language == "en" else "Публичные OAuth-метаданные доступны: ") + ENDPOINT)
                print("No login or authenticated tool call was tested." if args.language == "en"
                      else "Вход и вызов инструмента с авторизацией не проверялись.")
            return 0
        destination, files = installation_plan(workspace, source, args.client)
        print(messages["plan"].format(path=destination))
        print(messages["endpoint"])
        if args.dry_run:
            print(messages["dry"])
            if not args.install_only:
                if args.no_browser and args.client == "codex" and not args.login:
                    raise SetupError("manual_add")
                command = oauth_command(args.client, existing=args.login, client=args.client)
                if args.no_browser and (args.login or args.client == "codex"):
                    command.append("--no-browser")
                print(" ".join(command))
                if args.client == "claude" and not args.login:
                    print(" ".join(oauth_command("claude", existing=True, client="claude")
                                   + (["--no-browser"] if args.no_browser else [])))
            return 0
        if args.install_only:
            install(destination, files)
            print(messages["installed"])
            return 0
        cli = shutil.which(args.client)
        if cli is None:
            raise SetupError("cli")
        existing = connection_exists(cli, workspace, args.client)
        if not existing or args.login:
            command = oauth_command(cli, existing=existing, client=args.client)
            help_result = run_cli([cli, "mcp", "login" if args.client == "claude" else command[2], "--help"], workspace)
            required = ["--no-browser"] if args.client == "claude" else ["--oauth-client-registration"]
            if not existing and args.client == "codex":
                required.append("--oauth-resource")
            if args.no_browser and args.client == "codex":
                # Add has no --no-browser flag: configure through the normal flow,
                # or recover an existing entry with native login.
                if not existing:
                    raise SetupError("manual_add")
                required.append("--no-browser")
            if help_result.returncode or any(flag not in help_result.stdout for flag in required):
                raise SetupError("cli_version")
            check_discovery()
            install(destination, files)
            print(messages["browser"], flush=True)
            if args.client == "claude" and not existing:
                if run_cli(command, workspace).returncode:
                    raise SetupError("config")
                command = oauth_command(cli, existing=True, client="claude")
            if args.no_browser:
                command.append("--no-browser")
            if run_cli(command, workspace, interactive=True).returncode:
                raise SetupError("oauth")
        else:
            install(destination, files)
            print(messages["existing"])
        print(messages["installed"])
        print(messages["ready"])
        return 0
    except SetupError as exc:
        print(messages["failed"].format(reason=messages[exc.args[0]]), file=sys.stderr)
        return 1
    except OSError:
        print(messages["failed"].format(reason=messages["storage"]), file=sys.stderr)
        return 1
    except KeyboardInterrupt:
        print(messages["interrupted"], file=sys.stderr)
        return 130


if __name__ == "__main__":
    # Keep localized output readable when Windows launches Python with pipes.
    sys.stdout.reconfigure(encoding="utf-8")
    sys.stderr.reconfigure(encoding="utf-8")
    raise SystemExit(main())
