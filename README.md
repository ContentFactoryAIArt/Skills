# ContentFactory Skills

Connect Codex, Claude Code, or OpenCode to ContentFactory and install seven focused skills for assets, generation, compositions, 3D, photo editing, media processing, and research.

Install the agent CLI first. The installer adds one MCP endpoint and starts the agent's native sign-in in an interactive terminal. Select your projects, permissions, and spending limits during authorization. Each agent needs its own authorization.

## macOS and Linux

Choose codex, claude, or opencode in the command:

    installer=$(mktemp) && curl -fsSL https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main/install/install.sh -o "$installer" && sh "$installer" --agent codex

## Windows PowerShell

Choose codex, claude, or opencode in the command:

    $installer = Join-Path $env:TEMP 'contentfactory-install.ps1'; curl.exe -fsSL https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main/install/install.ps1 -o $installer; if ($LASTEXITCODE -eq 0) { powershell.exe -NoProfile -ExecutionPolicy Bypass -File $installer -Agent codex }

Restart your agent after installation. If sign-in is not started automatically, run the login command printed by the installer. A successful configuration alone does not verify authentication; try a read-only ContentFactory request after signing in.

## Updates and safety

Rerun the same installation command to update. To check without installing, add --check to the shell command or -Check to the PowerShell command. The versioned manifest lists checksums for the managed skill files. The installer protects locally modified files and existing same-named MCP connections; it asks you to inspect conflicts instead of replacing them.

If an interrupted installation leaves a lock, confirm that no installer is running, inspect the backup location recorded in the lock, recover any incomplete update, and only then remove the lock and retry.

The connected agent discovers the live operation schemas, supported capabilities, prices, and revisions. The operation-inventory.md file is a dated snapshot, not a substitute for live discovery. Paid operations require the appropriate authorization and budget.

The older project-scoped connector and guides remain in scripts/, docs/, and skills/contentfactory-video/ for existing users. The versioned installer above installs the seven current skills at user scope.