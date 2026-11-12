# ContentFactory Skills

Connect Codex, Claude Code, OpenCode, or Grok Build to ContentFactory and install a shared creative-workflow skill plus seven focused specialists for assets, generation, compositions, 3D, photo editing, media processing, and research.

Install the agent CLI first. The installer adds one MCP endpoint and guides the agent's native sign-in. Select your projects, permissions, and spending limits during authorization. Each agent needs its own authorization.

## macOS and Linux

Choose codex, claude, opencode, or grok in the command:

    installer=$(mktemp) && curl -fsSL https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main/install/install.sh -o "$installer" && sh "$installer" --agent codex

## Windows PowerShell

Choose codex, claude, opencode, or grok in the command:

    $installer = Join-Path $env:TEMP 'contentfactory-install.ps1'; curl.exe -fsSL https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main/install/install.ps1 -o $installer; if ($LASTEXITCODE -eq 0) { powershell.exe -NoProfile -ExecutionPolicy Bypass -File $installer -Agent codex }

Restart your agent after installation. If sign-in is not started automatically, run the login command printed by the installer. A successful configuration alone does not verify authentication; try a read-only ContentFactory request after signing in.

## Grok Build

Use `-Agent grok` on Windows or `--agent grok` on macOS/Linux with the commands above. Skills install to `~/.grok/skills`, or `$GROK_HOME/skills` when configured. The installer registers `https://content-factory.art/mcp` at user scope using Grok's native Streamable HTTP transport.

Start `grok`, open `/mcps`, select `content-factory`, press `i`, and complete ContentFactory consent in the browser. Open `/skills`, then use `/contentfactory` with your creative request. Run `grok mcp doctor content-factory` after signing in and request a read-only project listing to verify access. Grok account sign-in is available through `grok login`.

For videos on the user's PC, follow [Grok local-video intake](skills/contentfactory/references/grok.md). It covers authorized native review, runtime capability checks, and transfer into an owned ContentFactory project. The installer configures skills and MCP. Native full-video attachment syntax and limits require confirmation in the installed Grok version.

Native setup follows the [Grok MCP documentation](https://docs.x.ai/build/features/mcp-servers) and [skill documentation](https://docs.x.ai/build/features/skills-plugins-marketplaces).

## Updates and safety

Rerun the same installation command to update. To check without installing, add --check to the shell command or -Check to the PowerShell command. The versioned manifest lists checksums for the managed skill files. The installer protects locally modified files and existing same-named MCP connections; it asks you to inspect conflicts instead of replacing them.

If an interrupted installation leaves a lock, confirm that no installer is running, inspect the backup location recorded in the lock, recover any incomplete update, and only then remove the lock and retry.

The connected agent discovers the live operation schemas, supported capabilities, prices, and revisions. The operation-inventory.md file is a dated snapshot, not a substitute for live discovery. Paid operations require the appropriate authorization and budget.

Start ordinary creative requests with `$contentfactory`, or describe the media task normally. Specialist descriptions also route to the shared workflow. New ads load the advertising reference; small timecode edits load only the focused revision guidance. Creative execution and durable media/project state stay in ContentFactory; unavailable operations must be reported instead of silently replaced with local scripts. A skill or AGENTS.md guides the agent, but does not enforce a runtime boundary or prove worker execution.

For repeated work, create a campaign directory and copy `skills/contentfactory/assets/AGENTS.template.md` to its `AGENTS.md`. Keep only non-sensitive project locators there; brief, storyboard, assets, editable revisions and receipts belong to the ContentFactory project. A good request states the audience, desired action, source material and key language/style/budget constraints; precise corrections can name a timecode and desired behavior without technical layer IDs.

See [the user guide](docs/workflow.md) for new-ad briefs, source authorization, storyboard requests, exact timecode corrections and inexpensive review examples.

The older project-scoped connector and guides remain in scripts/, docs/, and skills/contentfactory-video/ for existing users. The versioned installer above installs the eight current skills and their referenced resources at user scope. The legacy standalone entrypoint remains usable, but the versioned bundle provides the current workflow and focused references.
