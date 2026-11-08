param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('codex', 'claude', 'opencode')]
    [string]$Agent,
    [switch]$Check,
    [switch]$InstallOnly
)
$ErrorActionPreference = 'Stop'
$base = 'https://raw.githubusercontent.com/ContentFactoryAIArt/Skills/main'
$endpoint = 'https://content-factory.art/mcp'
$server = 'content-factory'
$userRoot = [Environment]::GetFolderPath('UserProfile')
if ([string]::IsNullOrEmpty($userRoot)) { throw 'User profile directory is unavailable.' }
switch ($Agent) {
    'codex' { $root = Join-Path $userRoot '.agents/skills' }
    'claude' { $root = Join-Path $userRoot '.claude/skills' }
    'opencode' { $root = Join-Path $userRoot '.config/opencode/skills' }
}
$state = Join-Path $userRoot ".contentfactory/skills/$Agent/manifest.tsv"
$temp = Join-Path ([IO.Path]::GetTempPath()) ('contentfactory-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temp | Out-Null
$transaction = $false
$recoveryFailed = $false
$lockAcquired = $false
$lockPath = Join-Path $userRoot ".contentfactory/locks/$Agent.lock"
$old = $null
$new = $null

function Assert-NoLinks([string]$Path) {
    $item = [IO.Path]::GetFullPath($Path)
    while ($item) {
        if (Test-Path -LiteralPath $item) {
            $entry = Get-Item -LiteralPath $item -Force
            if (($entry.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
                throw 'Symbolic links and junctions are not supported in installation paths.'
            }
        }
        $parent = [IO.Directory]::GetParent($item)
        if ($null -eq $parent) { break }
        $item = $parent.FullName
    }
}
function Read-Manifest([string]$Path) {
    $lines = [IO.File]::ReadAllLines($Path, [Text.Encoding]::UTF8)
    if ($lines.Count -lt 2 -or $lines[0] -notmatch '^version\t([0-9]+\.[0-9]+\.[0-9]+)$') { throw 'Invalid skills manifest.' }
    $version = $Matches[1]
    $files = [ordered]@{}
    for ($i = 1; $i -lt $lines.Count; $i++) {
        $parts = $lines[$i].Split("`t")
        if ($parts.Count -ne 3 -or $parts[0] -cne 'file' -or $parts[1] -cnotmatch '^[a-f0-9]{64}$') { throw 'Invalid skills manifest record.' }
        $segments = $parts[2].Split('/')
        if ($segments.Count -lt 2 -or $segments[0] -cnotmatch '^[a-z0-9]+(-[a-z0-9]+)*$') { throw 'Invalid skill path.' }
        foreach ($segment in $segments[1..($segments.Count - 1)]) {
            if ($segment -cnotmatch '^[A-Za-z0-9_.-]+$' -or $segment -eq '.' -or $segment -eq '..') { throw 'Invalid skill path.' }
        }
        if ($files.Contains($parts[2])) { throw 'Duplicate skill path.' }
        $files[$parts[2]] = $parts[1]
    }
    return @{ Version = $version; Files = $files }
}
function Download([string]$Url, [string]$Destination) {
    # Both fixed endpoints are HTTPS; do not follow redirects to an untrusted host.
    $request = [Net.HttpWebRequest]::Create($Url)
    $request.AllowAutoRedirect = $false
    $request.Timeout = 90000
    $response = $null
    $output = $null
    $input = $null
    try {
        $response = $request.GetResponse()
        if ($response.ContentLength -gt 10485760) { throw 'Download exceeds the size limit.' }
        $input = $response.GetResponseStream()
        $output = [IO.File]::Open($Destination, [IO.FileMode]::CreateNew)
        $buffer = New-Object byte[] 32768
        $total = 0
        while (($count = $input.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $total += $count
            if ($total -gt 10485760) { throw 'Download exceeds the size limit.' }
            $output.Write($buffer, 0, $count)
        }
    } finally {
        if ($output) { $output.Dispose() }
        if ($input) { $input.Dispose() }
        if ($response) { $response.Dispose() }
    }
}
function File-Hash([string]$Path) { return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant() }
function Start-NativeLogin([string]$Executable, [string[]]$Arguments) {
    if (![Console]::IsInputRedirected -and ![Console]::IsOutputRedirected) {
        Write-Host 'Continue sign-in in the native agent and browser.'
        & $Executable @Arguments
        if ($LASTEXITCODE -ne 0) { throw "Sign-in did not complete. Retry: $Executable $($Arguments -join ' ')" }
    } else {
        Write-Host "To sign in, run: $Executable $($Arguments -join ' ')"
    }
}
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    $newFile = Join-Path $temp 'manifest.tsv'
    Download "$base/manifest.tsv" $newFile
    $new = Read-Manifest $newFile
    Assert-NoLinks $root
    Assert-NoLinks $state
    Assert-NoLinks $lockPath
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $lockPath) | Out-Null
    try {
        $lockFile = [IO.File]::Open($lockPath, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
        $lockFile.Dispose()
        $lockAcquired = $true
        [IO.File]::WriteAllText($lockPath, $temp)
    } catch {
        throw "Another installation may be running. After confirming it stopped, inspect $lockPath for its temporary backup location, recover any interrupted update, remove the lock, and retry."
    }
    $old = $null
    if (Test-Path -LiteralPath $state) { $old = Read-Manifest $state }
    if ($old) {
        foreach ($relative in $old.Files.Keys) {
            $target = Join-Path $root $relative
            Assert-NoLinks $target
            if (!(Test-Path -LiteralPath $target -PathType Leaf) -or (File-Hash $target) -cne $old.Files[$relative]) {
                throw "Locally changed or missing managed file: $relative; no update applied."
            }
        }
    }
    if ($Check) {
        if (!$old) { Write-Host "Not installed; available version: $($new.Version)" }
        elseif ((File-Hash $state) -ceq (File-Hash $newFile)) { Write-Host "Installed manifest is current: $($new.Version)" }
        else { Write-Host "An update is available: $($new.Version)" }
        return
    }
    foreach ($relative in $new.Files.Keys) {
        $target = Join-Path $root $relative
        Assert-NoLinks $target
        $owned = $old -and $old.Files.Contains($relative)
        if ((Test-Path -LiteralPath $target) -and !$owned) { throw "Unmanaged file conflicts: $relative; no update applied." }
        $staged = Join-Path $temp ('files/' + $relative)
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $staged) | Out-Null
        Download "$base/skills/$relative" $staged
        if ((File-Hash $staged) -cne $new.Files[$relative]) { throw "Checksum mismatch: $relative" }
    }
    if ($old) {
        foreach ($relative in $old.Files.Keys) {
            $backup = Join-Path $temp ('backup/' + $relative)
            New-Item -ItemType Directory -Force -Path (Split-Path -Parent $backup) | Out-Null
            Copy-Item -LiteralPath (Join-Path $root $relative) -Destination $backup
        }
        Copy-Item -LiteralPath $state -Destination (Join-Path $temp 'previous-manifest')
    }
    $transaction = $true
    foreach ($relative in $new.Files.Keys) {
        $target = Join-Path $root $relative
        $parent = Split-Path -Parent $target
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
        $stagedTarget = Join-Path $parent ('.contentfactory-' + [guid]::NewGuid().ToString('N'))
        Copy-Item -LiteralPath (Join-Path $temp ('files/' + $relative)) -Destination $stagedTarget
        Move-Item -LiteralPath $stagedTarget -Destination $target -Force
    }
    if ($old) {
        foreach ($relative in $old.Files.Keys) {
            if (!$new.Files.Contains($relative)) { Remove-Item -LiteralPath (Join-Path $root $relative) }
        }
    }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $state) | Out-Null
    $nextState = "$state.$([guid]::NewGuid().ToString('N'))"
    Copy-Item -LiteralPath $newFile -Destination $nextState
    Move-Item -LiteralPath $nextState -Destination $state -Force
    $transaction = $false
    Write-Host "Installed ContentFactory skills version $($new.Version) for $Agent."
    if ($InstallOnly) { return }
    if (!(Get-Command $Agent -ErrorAction SilentlyContinue)) { throw "Install $Agent, then rerun this installer to connect MCP." }
    if ($Agent -eq 'opencode') {
        $previousPreference = $ErrorActionPreference
        try {
            $ErrorActionPreference = 'Continue'
            $help = & opencode mcp add --help 2>&1 | Out-String
            $helpExit = $LASTEXITCODE
        } finally { $ErrorActionPreference = $previousPreference }
        if ($helpExit -ne 0 -or !$help.Contains('--url')) { throw 'OpenCode does not support noninteractive URL configuration; configuration was not changed.' }
        $hasGlobalFlag = $help.Contains('--global')
        if (!$hasGlobalFlag) {
            $version = & opencode --version 2>$null | Out-String
            if ($LASTEXITCODE -ne 0 -or $version.Trim() -notmatch '^1\.[0-9]+\.[0-9]+$') { throw 'Unsupported OpenCode version; configuration was not changed.' }
        }
        $listing = & opencode mcp list 2>$null | Out-String
        if ($LASTEXITCODE -ne 0) { throw 'OpenCode could not list connections; configuration was not changed.' }
        if ($listing.Contains($server)) {
            throw "An MCP server named $server may already exist; it was not changed. Review it with opencode mcp list."
        }
        if ($hasGlobalFlag) { & opencode mcp add $server --global --url $endpoint }
        else { & opencode mcp add $server --url $endpoint }
        if ($LASTEXITCODE -ne 0) { throw 'OpenCode could not add the server.' }
        Start-NativeLogin 'opencode' @('mcp', 'auth', $server)
        Write-Host 'Connection and authentication are verified by your next MCP call.'
        return
    }
    # The existing entry could be customized; leave it untouched and never print it.
    $probeArgs = @('mcp', 'get', $server)
    if ($Agent -eq 'codex') { $probeArgs += '--json' }
    # Windows PowerShell 5 treats redirected native stderr as an error record.
    # Capture it under Continue, then fail closed on unfamiliar diagnostics.
    $previousPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $probe = @(& $Agent @probeArgs 2>&1 | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] })
        $probeExit = $LASTEXITCODE
    } finally { $ErrorActionPreference = $previousPreference }
    if ($probeExit -eq 0) {
        Write-Host "An MCP server named $server already exists; it was not changed. Check its endpoint and sign-in in $Agent."
        return
    }
    $lines = @($probe | ForEach-Object { $_.ToString().Trim() } | Where-Object { $_ })
    if ($Agent -eq 'codex') {
        $lines = @($lines | Where-Object { -not $_.StartsWith('WARNING: proceeding, even though we could not create PATH aliases:') })
        $expected = "Error: No MCP server named '$server' found."
    } else {
        $expected = 'No MCP server named "' + $server + '". Run `claude mcp add` to add one.'
    }
    if ($lines.Count -ne 1 -or $lines[0] -cne $expected) { throw 'The agent returned an unexpected inspection error; no connection was changed.' }
    Write-Host "Adding the $server MCP server. Complete authorization using your agent's native sign-in."
    if ($Agent -eq 'codex') {
        & $Agent mcp add $server --url $endpoint --oauth-client-registration dcr --oauth-resource $endpoint
        if ($LASTEXITCODE -ne 0) { throw 'Codex could not add the server.' }
        Start-NativeLogin 'codex' @('mcp', 'login', $server, '--oauth-client-registration', 'dcr')
    } else {
        & $Agent mcp add --transport http $server --scope user $endpoint
        if ($LASTEXITCODE -ne 0) { throw 'Claude Code could not add the server.' }
        Start-NativeLogin 'claude' @('mcp', 'login', $server)
    }
    Write-Host 'Connection and authentication are verified by your next MCP call.'
} catch {
    if ($transaction) {
        foreach ($relative in $new.Files.Keys) {
            try {
                $target = Join-Path $root $relative
                $owned = $old -and $old.Files.Contains($relative)
                if ((Test-Path -LiteralPath $target -PathType Leaf) -and (File-Hash $target) -ceq $new.Files[$relative]) {
                    if ($owned) { Copy-Item -LiteralPath (Join-Path $temp ('backup/' + $relative)) -Destination $target -Force }
                    else { Remove-Item -LiteralPath $target -Force }
                } elseif ($owned -and !(Test-Path -LiteralPath $target)) {
                    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
                    Copy-Item -LiteralPath (Join-Path $temp ('backup/' + $relative)) -Destination $target
                } elseif ($owned -and (Test-Path -LiteralPath $target -PathType Leaf) -and (File-Hash $target) -ceq $old.Files[$relative]) {
                    # Unchanged since the transaction started.
                } elseif (!$owned -and !(Test-Path -LiteralPath $target)) {
                    # This file was not yet installed.
                } else { $recoveryFailed = $true }
            } catch { $recoveryFailed = $true }
        }
        if ($old) {
            foreach ($relative in $old.Files.Keys) {
                if (!$new.Files.Contains($relative)) {
                    try {
                        $target = Join-Path $root $relative
                        if (!(Test-Path -LiteralPath $target)) {
                            New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
                            Copy-Item -LiteralPath (Join-Path $temp ('backup/' + $relative)) -Destination $target
                        } elseif (!(Test-Path -LiteralPath $target -PathType Leaf) -or (File-Hash $target) -cne $old.Files[$relative]) { $recoveryFailed = $true }
                    } catch { $recoveryFailed = $true }
                }
            }
            try { Copy-Item -LiteralPath (Join-Path $temp 'previous-manifest') -Destination $state -Force } catch { $recoveryFailed = $true }
        } else {
            try { if (Test-Path -LiteralPath $state) { Remove-Item -LiteralPath $state -Force } } catch { $recoveryFailed = $true }
        }
        if ($recoveryFailed) { Write-Warning "Automatic recovery was incomplete; backups are in $temp and the lock remains at $lockPath" }
        else { Write-Warning 'Installation was interrupted; previous managed files were restored.' }
    }
    throw
} finally {
    if ($lockAcquired -and !$recoveryFailed) { Remove-Item -LiteralPath $lockPath -Force }
    if (!$recoveryFailed -and (Test-Path -LiteralPath $temp)) { Remove-Item -LiteralPath $temp -Recurse -Force }
}
