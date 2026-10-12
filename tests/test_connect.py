from contextlib import redirect_stderr, redirect_stdout
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch


MODULE_PATH = Path(__file__).resolve().parents[1] / "scripts" / "connect.py"
SPEC = importlib.util.spec_from_file_location("contentfactory_connect", MODULE_PATH)
connect = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(connect)


def cli_result(code=0, stdout="", stderr=""):
    return subprocess.CompletedProcess([], code, stdout, stderr)


def server_config(**changes):
    result = {
        "name": connect.SERVER_NAME,
        "enabled": True,
        "transport": {"type": "streamable_http", "url": connect.ENDPOINT},
    }
    result.update(changes)
    return result


class ConnectorTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.workspace = Path(self.temp.name)
        self.output = io.StringIO()
        self.addCleanup(self.output.close)

    def run_main(self, *args):
        with redirect_stdout(self.output), redirect_stderr(self.output):
            return connect.main(["--workspace", str(self.workspace), *args])

    def test_dry_run_does_not_call_client_network_or_write(self):
        with patch.object(connect, "run_cli") as native, patch.object(connect, "check_discovery") as discovery:
            self.assertEqual(self.run_main("--dry-run"), 0)
        native.assert_not_called()
        discovery.assert_not_called()
        self.assertEqual(list(self.workspace.iterdir()), [])
        self.assertIn(connect.ENDPOINT, self.output.getvalue())

    def test_install_only_is_self_contained_and_repeatable(self):
        with patch.object(connect, "run_cli") as native, patch.object(connect, "check_discovery") as discovery:
            self.assertEqual(self.run_main("--install-only"), 0)
            installed = self.workspace / ".agents" / "skills" / connect.SKILL_NAME
            before = {path.relative_to(installed): (path.read_bytes(), path.stat().st_mtime_ns)
                      for path in installed.rglob("*") if path.is_file()}
            self.assertEqual(self.run_main("--install-only", "--language", "ru"), 0)
            after = {path.relative_to(installed): (path.read_bytes(), path.stat().st_mtime_ns)
                     for path in installed.rglob("*") if path.is_file()}
        native.assert_not_called()
        discovery.assert_not_called()
        self.assertEqual(before, after)
        self.assertIn(Path("references/blender.md"), after)
        self.assertIn(Path("references/ru.md"), after)
        self.assertIn(Path("agents/openai.yaml"), after)

    def test_different_skill_is_preserved(self):
        installed = self.workspace / ".agents" / "skills" / connect.SKILL_NAME
        installed.mkdir(parents=True)
        target = installed / "SKILL.md"
        target.write_text("user edits", encoding="utf-8")
        with patch.object(connect, "run_cli") as native:
            self.assertEqual(self.run_main("--install-only"), 1)
        native.assert_not_called()
        self.assertEqual(target.read_text(encoding="utf-8"), "user edits")
        self.assertEqual(list(installed.iterdir()), [target])

    def test_existing_connection_does_not_repeat_oauth_or_discovery(self):
        with patch.object(connect.shutil, "which", return_value="codex"), \
                patch.object(connect, "run_cli", return_value=cli_result(stdout=json.dumps(server_config()))) as native, \
                patch.object(connect, "check_discovery") as discovery:
            self.assertEqual(self.run_main(), 0)
            self.assertEqual(self.run_main(), 0)
        self.assertEqual(native.call_count, 2)
        for call in native.call_args_list:
            self.assertEqual(call.args[0], ["codex", "mcp", "get", connect.SERVER_NAME, "--json"])
        discovery.assert_not_called()
        self.assertIn("No add or login was run", self.output.getvalue())

    def test_first_connect_adds_once_with_bound_resource(self):
        calls = [
            cli_result(1, stderr=f"Error: No MCP server named '{connect.SERVER_NAME}' found."),
            cli_result(stdout="--oauth-client-registration --oauth-resource"),
            cli_result(),
        ]
        with patch.object(connect.shutil, "which", return_value="codex"), \
                patch.object(connect, "run_cli", side_effect=calls) as native, \
                patch.object(connect, "check_discovery") as discovery:
            self.assertEqual(self.run_main(), 0)
        discovery.assert_called_once()
        self.assertEqual(native.call_args_list[-1].args[0], [
            "codex", "mcp", "add", connect.SERVER_NAME, "--url", connect.ENDPOINT,
            "--oauth-client-registration", "dcr", "--oauth-resource", connect.ENDPOINT,
        ])
        self.assertFalse(any(call.args[0][2] == "login" for call in native.call_args_list))

    def test_explicit_login_keeps_existing_configuration(self):
        calls = [cli_result(stdout=json.dumps(server_config())),
                 cli_result(stdout="--oauth-client-registration"), cli_result()]
        with patch.object(connect.shutil, "which", return_value="codex"), \
                patch.object(connect, "run_cli", side_effect=calls) as native, \
                patch.object(connect, "check_discovery"):
            self.assertEqual(self.run_main("--login"), 0)
        self.assertEqual(native.call_args_list[-1].args[0], [
            "codex", "mcp", "login", connect.SERVER_NAME, "--oauth-client-registration", "dcr",
        ])
        self.assertFalse(any(call.args[0][2] == "add" for call in native.call_args_list))

    def test_unavailable_endpoint_prevents_add_and_install(self):
        calls = [cli_result(1, stderr=f"Error: No MCP server named '{connect.SERVER_NAME}' found."),
                 cli_result(stdout="--oauth-client-registration --oauth-resource")]
        with patch.object(connect.shutil, "which", return_value="codex"), \
                patch.object(connect, "run_cli", side_effect=calls) as native, \
                patch.object(connect, "check_discovery", side_effect=connect.SetupError("metadata")):
            self.assertEqual(self.run_main(), 1)
        self.assertEqual(native.call_count, 2)
        self.assertEqual(list(self.workspace.iterdir()), [])

    def test_client_error_is_not_treated_as_missing_server_or_printed(self):
        with patch.object(connect.shutil, "which", return_value="codex"), \
                patch.object(connect, "run_cli", return_value=cli_result(1, stderr="private-diagnostic-test-value")) as native:
            self.assertEqual(self.run_main(), 1)
        self.assertEqual(native.call_count, 1)
        self.assertNotIn("private-diagnostic-test-value", self.output.getvalue())
        self.assertEqual(list(self.workspace.iterdir()), [])

    def test_untrusted_endpoint_disabled_or_custom_auth_are_not_modified(self):
        cases = [
            server_config(transport={"type": "streamable_http", "url": "https://other.example/mcp"}),
            server_config(enabled=False),
            server_config(transport={"type": "streamable_http", "url": connect.ENDPOINT,
                                     "http_headers": {"Authorization": "test-private-header"}}),
            server_config(transport={"type": "stdio", "command": "not-trusted"}),
        ]
        for config in cases:
            with self.subTest(config=config), patch.object(connect.shutil, "which", return_value="codex"), \
                    patch.object(connect, "run_cli", return_value=cli_result(stdout=json.dumps(config))) as native:
                self.assertEqual(self.run_main(), 1)
                self.assertEqual(native.call_count, 1)
        self.assertNotIn("test-private-header", self.output.getvalue())
        self.assertEqual(list(self.workspace.iterdir()), [])

    def test_bad_metadata_is_rejected(self):
        valid = {"resource": connect.ENDPOINT, "authorization_servers": ["https://content-factory.art"]}
        self.assertTrue(connect.metadata_valid(valid))
        cases = [None, [], {}, {**valid, "resource": "https://content-factory.art/mcp/media"},
                 {**valid, "authorization_servers": ["http://content-factory.art"]},
                 {**valid, "authorization_servers": ["https://content-factory.art.evil.example"]},
                 {**valid, "authorization_servers": ["https://user@content-factory.art"]},
                 {**valid, "authorization_servers": ["https://content-factory.art?token=x"]},
                 {**valid, "authorization_servers": []}]
        for document in cases:
            with self.subTest(document=document):
                self.assertFalse(connect.metadata_valid(document))

    def test_redirects_are_not_followed(self):
        self.assertIsNone(connect.NoRedirects().redirect_request(None, None, 302, "", {}, "https://other.example"))

    def test_metadata_response_is_bounded(self):
        response = io.BytesIO(b" " * (connect.MAX_METADATA_BYTES + 1))
        with patch.object(connect, "build_opener") as opener:
            opener.return_value.open.return_value = response
            with self.assertRaisesRegex(connect.SetupError, "metadata"):
                connect.check_discovery()

    def test_package_links_resolve_inside_skill(self):
        import re
        root = MODULE_PATH.parents[1] / "skills" / connect.SKILL_NAME
        for document in root.rglob("*.md"):
            for target in re.findall(r"\]\(([^)]+)\)", document.read_text(encoding="utf-8")):
                if "://" in target or target.startswith("#"):
                    continue
                reference = (document.parent / target.split("#")[0]).resolve()
                self.assertTrue(reference.is_relative_to(root), (document, target))
                self.assertTrue(reference.is_file(), (document, target))


if __name__ == "__main__":
    unittest.main()
