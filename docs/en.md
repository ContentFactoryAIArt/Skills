# Get started with ContentFactory

ContentFactory is a free browser editor for photos, video and 3D. Connect your
own Codex or Claude Code agent to edit those projects or produce complete videos.
Generation and model-assisted analysis can cost money; the agent must use your
budget and live quotes. Your agent subscription is separate from ContentFactory.

## Start in four steps

1. Install Python 3.11+ and the current official [Codex CLI](https://developers.openai.com/codex/cli)
   or [Claude Code](https://code.claude.com/docs/en/setup). Choose an existing
   project folder. You need a ContentFactory account with access to a project;
   setup does not create an account or grant project membership.
2. [Download and extract the ZIP](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip),
   or clone `https://github.com/ContentFactoryAIArt/Skills.git` and open that folder.
3. Run **one** command for your client, replacing the existing project path:

   ```powershell
   python scripts/connect.py --client codex --workspace "C:\Projects\MyVideo"
   python scripts/connect.py --client claude --workspace "C:\Projects\MyVideo"
   ```

   On macOS/Linux use `python3` and an existing path such as `~/projects/my-video`.
   Finish the native browser flow. Select projects, permissions, spending access
   and lifetime. Account sign-in and consent may be separate screens in one flow.
4. Open/reload that project in your client. Use `$contentfactory-video` in Codex
   or `/contentfactory-video` in Claude Code. For example:

   > Correct the exposure and color in my selected photo, preserve the original,
   > and save the look as a recipe. Do not use paid generation.

   Or:

   > Make a 30-second product video from my selected assets. Use captions, music
   > and a 3D title if supported. Show the plan and quote before paid work.
   > Keep the timeline editable and deliver the final video.

The skill also covers masks, effects, vector artwork, audio DSP, materials, UVs,
lighting, Grease Pencil and Blender animation. It discovers current capabilities;
it does not promise every desktop editor feature or every provider model.
Instructions are in English; conversation and creative output follow your language.
Upload local media through ContentFactory first and select the resulting assets.

## Codex: Guided Setup

The helper installs `.agents/skills/contentfactory-video` in your project.
It uses native `codex mcp get/add/login` and requires the documented
`--oauth-client-registration` and `--oauth-resource` options. Update Codex if the
helper reports missing options. The CLI manages the MCP configuration at its
normal scope; the skill is project-local.

A new `codex mcp add` starts OAuth itself. Setup does **not** follow it with a
second login. An existing compatible named connection is preserved.

## Claude Code: Guided Setup

Use `--client claude`. The helper installs `.claude/skills/contentfactory-video`,
adds `content-factory` with native HTTP transport and local scope (private to you
in this project), then runs `claude mcp login content-factory` once. Current
Claude Code is required; older versions without native MCP login must be updated.
Existing compatible connections at a visible scope are reused without re-login.

Manual equivalent when the skill is already installed:

```sh
claude mcp add --transport http --scope local content-factory https://content-factory.art/mcp
claude mcp login content-factory
```

Add only if the named server is absent. `/mcp` inside Claude Code can also manage
its connection and authorization. Invoke the installed skill with
`/contentfactory-video`; `agents/openai.yaml` is Codex metadata and is not required
for Claude Code's skill discovery.

## Other MCP Clients

Use one Streamable HTTP connection to `https://content-factory.art/mcp` with
OAuth/PKCE and Dynamic Client Registration. Install the whole skill folder
through the client's skill mechanism if supported. Never copy tokens between
clients or paste credentials into chat. Using both Codex and Claude Code requires
one ContentFactory authorization **per client**, not three domain logins each.

## Keep the Connection

Reopening a conversation or installing instructions does not require a new
OAuth grant. Setup reuses a matching enabled connection; it does not test its
stored credential. After setup, ask the agent to discover and read `projects_list`
and the relevant capabilities through the unified connection. Choose an authorized
project. This read proves access without submitting paid work. If no projects are
visible, create/select a project in ContentFactory and check the grant's projects.

For a confirmed expired, revoked or interrupted grant, use explicit recovery:

```sh
python scripts/connect.py --client codex --workspace /path/to/project --login
python scripts/connect.py --client claude --workspace /path/to/project --login
```

Do not run both unless you are recovering both clients. Native OAuth keeps its
terminal visible, so browser/manual callback instructions are not hidden. On a
headless machine, Claude supports `--no-browser`; Codex supports it for recovery
with `--login`. If first-time Codex setup cannot open a browser, interrupt it and
repeat with `--login --no-browser` once its named server entry exists. Follow
native callback instructions in your terminal; do not paste sign-in URLs in chat.

Legacy `/mcp/media`, `/mcp/generate` and `/mcp/compose` grants have different
OAuth audiences. Moving to `/mcp` needs one new consent. The helper does not
remove old entries; verify the unified connection before disabling them.
Manage/revoke grants at https://content-factory.art/settings/tokens. Expiry,
revocation and membership changes can require authorization again.

## Diagnostics and Safe Installation

```sh
# Preview without client access, writes or network:
python scripts/connect.py --client claude --workspace . --dry-run
# Check public OAuth discovery without logging in or changing anything:
python scripts/connect.py --workspace . --check
# Install only (choose your client):
python scripts/connect.py --client claude --workspace /path/to/project --install-only
```

A discovery pass is not an authenticated tool call or a media acceptance test.
An unavailable unified endpoint needs an operator fix; the helper never adds three
legacy servers as a fallback. It leaves other MCP servers and credentials alone.
A conflicting endpoint/custom authentication is not overwritten. Existing skill
files must match the package; preserve edited copies before removing the exact
old skill directory and reinstalling an updated release. Do not delete unrelated
skills or client configuration. Symbolic links and junctions are refused.

## Tools and Privacy

The skill uses only tools from the verified `https://content-factory.art/mcp`
connection. Client settings provide provenance; a familiar tool alias is not
proof. Four envelope tools discover, describe, read and execute the live catalog.
The agent loads only the workflow references needed for the task and saves useful
recovery state through ContentFactory.

There are no local processing, browser automation, external-provider or alternate
MCP fallbacks for creative work. The setup helper is separate from execution and
lets each native client manage OAuth. It does not read credential files, copy
access tokens or print raw configuration. Client approvals and server permission,
project, lifetime and budget checks remain in force.

Official references: [Codex MCP](https://developers.openai.com/codex/mcp/),
[Codex skills](https://developers.openai.com/codex/skills/),
[Claude Code MCP](https://code.claude.com/docs/en/mcp),
[Claude Code skills](https://code.claude.com/docs/en/skills).
[All ten language guides](../README.md#choose-your-language).
