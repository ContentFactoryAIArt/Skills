# Get started with ContentFactory

Create videos, images, voiceovers, music, and editable compositions with your AI
agent through ContentFactory. The skill instructions are in English, while your
conversation and creative output can use the language you choose.

## Start in four steps

1. Install Python 3.11+ and the current Codex CLI. Pick an existing project folder.
2. [Download this repository as a ZIP](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip)
   and extract it, or run:

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. From the extracted or cloned repository folder, run the helper with your own
   existing project folder:

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   On macOS or Linux, use `python3` and a path such as
   `~/projects/my-video`. Finish sign-in in the browser and select your
   projects, permissions, and access lifetime.
4. Open or reload the project in Codex and ask:

   > Use $contentfactory-video to make a 30-second product video in English.
   > Work in my selected project and show the expected cost before paid work.

If setup reports that the unified endpoint is unavailable, the corresponding
ContentFactory server release is needed. `--install-only` can prepare the skill,
but creative work still needs a live connection.

## Contents

- [Codex setup details](#codex-guided-setup)
- [Other MCP clients](#other-mcp-clients)
- [Keep or recover your connection](#keep-the-connection)
- [Tools and privacy](#tools-and-privacy)
- [All ten language guides](../README.md#choose-your-language)

ContentFactory has one public MCP address for Media, Generate and Compose:

```text
https://content-factory.art/mcp
```

Choose Streamable HTTP in your agent. Sign in through the ContentFactory browser
page, select projects and permissions, and choose a token lifetime. Enable paid
operations only when you need them. Account sign-in and approval of the MCP grant
can be separate screens in this one connection flow.

This unified endpoint requires the corresponding server release. The helper
checks public OAuth discovery before starting authorization; an unavailable
endpoint is reported without adding legacy connections or weakening security.

## Codex: Guided Setup

Requires Python 3.11+ and the official Codex CLI with
`--oauth-client-registration` and `--oauth-resource` support. Run the helper
from the repository folder as shown above; `--client codex` is optional.

On Windows, use a quoted existing path, for example
`--workspace "C:\Projects\MyVideo"`. The helper installs
`.agents/skills/contentfactory-video` in that project and adds the named
`content-factory` server through Codex's native CLI. MCP configuration is managed
by the client's normal configuration scope; the skill itself is project-local.

If the same named connection is already enabled at the correct address, the
helper retains it and does not add the server or sign in again. It refuses a
different endpoint or custom authentication configuration rather than replacing
it. Existing skill files must match the package; edits are never overwritten.

To inspect the plan without changing files, contacting the server or reading
client configuration:

```sh
python scripts/connect.py --workspace /path/to/your/project --dry-run
```

To install instructions when MCP is already configured through your app, without
touching the CLI or starting OAuth:

```sh
python scripts/connect.py --workspace /path/to/your/project --install-only
```

Reload your workspace's skills in Codex and invoke `$contentfactory-video`.
For example: "Use $contentfactory-video to make a 30-second product video in
English. Use my selected project and keep the total spend below my stated budget."
The first MCP read verifies live access; installation alone does not prove that
OAuth completed or that a paid provider is available.

## Other MCP Clients

In a client supporting remote Streamable HTTP MCP with OAuth and PKCE, add the
address above as one server. Use the client's normal browser sign-in. If your
client offers a client-registration setting, choose Dynamic Client Registration
(DCR). Do not paste passwords, bearer tokens or client secrets into chat.

Install the complete `skills/contentfactory-video` folder through the client's
normal skill feature. For Claude Code, the project location is
`.claude/skills/contentfactory-video`; configure the remote server through
Claude Code's MCP settings and authorize it through its normal `/mcp` flow.
In Claude Code's terminal, the documented add command is:

```sh
claude mcp add --transport http content-factory https://content-factory.art/mcp
```

Run `/mcp` inside Claude Code to finish authorization. If that server is already
configured at the same address, reuse it instead of adding it again.
The Python helper currently automates Codex only. Clients without skill support
can use MCP, but this package does not claim to install a skill into them.

## Keep the Connection

Adding or updating skill instructions does not require OAuth. Reopening a
conversation does not require adding servers. The client retains its delegated
credential until expiry or revocation; account/project permission changes can
also remove access. Keep the same named connection and let the client manage it.

For a confirmed expired, revoked or incomplete grant, explicitly sign in again:

```sh
python scripts/connect.py --workspace /path/to/your/project --login
```

This is a recovery action, not a command to run after every successful setup.
Native `codex mcp add` already starts its OAuth flow; do not routinely follow it
with a second `codex mcp login`.

The helper relies on Codex opening a browser automatically and suppresses raw
client output. If no browser opens, press Ctrl+C. The native add may already
have saved its server entry. From your own terminal, recover that existing
connection with the native manual browser flow:

```sh
codex mcp login content-factory --oauth-client-registration dcr --no-browser
```

Follow the URL and callback instructions shown by Codex in your terminal; do
not paste these URLs into chat. If Codex explicitly reports that the server
does not exist, add it once directly, then follow its normal browser flow:

```sh
codex mcp add content-factory --url https://content-factory.art/mcp --oauth-client-registration dcr --oauth-resource https://content-factory.art/mcp
```

Only use this fallback when setup was interrupted or failed, after the unified
server endpoint is available. If you manually configured MCP, run the helper
with `--install-only` to install its instructions without another login.

Existing `/mcp/media`, `/mcp/generate` and `/mcp/compose` grants are bound to their
original resources. Moving to `/mcp` requires one new consent. Verify the unified
connection, then disable old entries in your client. The helper does not delete
old configuration or revoke tokens for you.

Manage/revoke delegated tokens at https://content-factory.art/settings/tokens.
Use the shortest lifetime that fits your work. Non-expiring access is optional
and requires explicit consent; it remains revocable. One shared endpoint does
not remove project boundaries, permissions, spending limits or PKCE validation.

## Tools and Privacy

The skill uses only tools whose verified server endpoint is
`https://content-factory.art/mcp`. An alias or familiar tool name is insufficient.
If your client hides server provenance, verify/configure that connection before
running the skill. Client tool approvals remain enabled; the skill is guidance,
not a sandbox or a replacement for server authorization.

There are no external AI, browser, local media-processing or upload fallbacks.
Upload local sources through ContentFactory and select their owned assets. If a
native capability or review is unavailable, the agent reports the limitation.
The setup helper is separate from creative execution: it checks public discovery,
asks the native CLI for the one named server's configuration, and lets that CLI
own OAuth. It does not read credential stores, receive tokens, alter unrelated
servers or print raw client configuration.

Start guides are available in all ten languages supported by the public site.
The creative skill follows the user's chosen language.

Official client references: https://developers.openai.com/codex/mcp/ and
https://code.claude.com/docs/en/mcp and https://code.claude.com/docs/en/skills.
