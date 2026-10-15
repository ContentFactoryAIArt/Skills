"""Opt-in real CLI checks using empty profiles, without completing OAuth.

Set CONTENTFACTORY_TEST_CODEX / CONTENTFACTORY_TEST_CLAUDE to official binaries.
Claude's native get contacts the public server without a token.
"""

from contextlib import redirect_stderr, redirect_stdout
import io
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
from urllib.error import HTTPError
from urllib.parse import parse_qs, urlsplit
from urllib.request import build_opener

from test_connect import connect


class NativeClientTests(unittest.TestCase):
    def exercise(self, client):
        executable = os.environ.get("CONTENTFACTORY_TEST_" + client.upper())
        if not executable:
            self.skipTest("official CLI path not supplied")
        with tempfile.TemporaryDirectory(prefix="cf-native-client-") as directory:
            root = Path(directory)
            profile, workspace = root / "profile", root / "project"
            profile.mkdir()
            workspace.mkdir()
            environment = {key: value for key, value in os.environ.items()
                           if key not in {"ANTHROPIC_API_KEY", "ANTHROPIC_AUTH_TOKEN",
                                          "CLAUDE_CODE_OAUTH_TOKEN", "OPENAI_API_KEY"}}
            environment.update(CODEX_HOME=str(profile), CLAUDE_CONFIG_DIR=str(profile),
                               NODE_TLS_REJECT_UNAUTHORIZED="1")
            with patch.dict(os.environ, environment, clear=True):
                self.assertFalse(connect.connection_exists(executable, workspace, client))
                if client == "codex":
                    # Synthetic nonsecret config avoids add's automatic OAuth.
                    (profile / "config.toml").write_text(
                        '[mcp_servers.content-factory]\nurl = "' + connect.ENDPOINT + '"\n', encoding="utf-8")
                else:
                    result = connect.run_cli(connect.oauth_command(executable, existing=False, client=client), workspace)
                    self.assertEqual(result.returncode, 0, "native MCP add failed")
                self.assertTrue(connect.connection_exists(executable, workspace, client))
                output = io.StringIO()
                with redirect_stdout(output), redirect_stderr(output), \
                        patch.object(connect.shutil, "which", return_value=executable):
                    self.assertEqual(connect.main(["--client", client, "--workspace", str(workspace)]), 0)
                    self.assertEqual(connect.main(["--client", client, "--workspace", str(workspace)]), 0)
                self.assertIn("No add or login was run", output.getvalue())
                owner = ".agents" if client == "codex" else ".claude"
                self.assertTrue((workspace / owner / "skills" / connect.SKILL_NAME / "SKILL.md").is_file())
                result = connect.run_cli([executable, "mcp", "login", "--help"], workspace)
                self.assertEqual(result.returncode, 0)
                self.assertIn("--no-browser", result.stdout)
                if os.environ.get("CONTENTFACTORY_TEST_OAUTH_HANDOFF") == "1":
                    self.verify_oauth_handoff(executable, client, workspace)

    def verify_oauth_handoff(self, executable, client, workspace):
        # Real DCR/PKCE up to consent, with no browser and no existing credentials.
        # Registration creates a public OAuth client but grants no account access.
        if client == "claude" and not sys.stdin.isatty():
            self.skipTest("Claude manual OAuth requires an interactive terminal")
        command = connect.oauth_command(executable, existing=True, client=client) + ["--no-browser"]
        process = subprocess.Popen(command, cwd=workspace, stdin=None if client == "claude" else subprocess.PIPE,
                                   stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                   text=True, encoding="utf-8", errors="replace")
        try:
            output, _ = process.communicate(timeout=15)
        except subprocess.TimeoutExpired:
            process.kill()
            output, _ = process.communicate(timeout=5)
        # Never print captured OAuth output or URLs, including on an assertion failure.
        # OSC hyperlinks may terminate with BEL instead of ESC; stop at all controls.
        match = re.search(r'https://content-factory\.art/oauth/authorize\?[^\s\x00-\x1f\x7f]+', output)
        self.assertTrue(match is not None, "native client did not reach the public authorization URL")
        url = match.group(0)
        query = parse_qs(urlsplit(url).query)
        self.assertTrue(set(query.get("resource", [])) == {connect.ENDPOINT}, "unexpected OAuth resource")
        self.assertTrue(query.get("code_challenge_method") == ["S256"], "PKCE S256 missing")
        self.assertTrue(query.get("state"))
        self.assertTrue(query.get("code_challenge"))
        try:
            response = build_opener(connect.NoRedirects()).open(url, timeout=15)
        except HTTPError as error:
            response = error
        with response:
            self.assertEqual(response.status, 302, "server rejected native DCR/PKCE handoff")
            target = urlsplit(response.headers.get("Location", ""))
            self.assertEqual(target.scheme, "https")
            self.assertEqual(target.netloc, "content-factory.art")
            self.assertTrue(parse_qs(target.query).get("authorization_request"))

    def test_codex_native_empty_profile_and_reuse(self):
        self.exercise("codex")

    def test_claude_native_empty_profile_and_reuse(self):
        self.exercise("claude")
