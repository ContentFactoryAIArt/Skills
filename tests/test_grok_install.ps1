param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)
$ErrorActionPreference = 'Stop'
$TestRepository = [IO.Path]::GetFullPath($RepositoryRoot)
$grokCommand = (Get-Command grok -ErrorAction Stop).Source
$testRoot = Join-Path ([IO.Path]::GetTempPath()) ('contentfactory-grok-test-' + [guid]::NewGuid().ToString('N'))
$savedGrokHome = $env:GROK_HOME
$utf8 = New-Object Text.UTF8Encoding($false)

function Assert-True([bool]$Condition, [string]$Message) {
    if (!$Condition) { throw $Message }
}

try {
    New-Item -ItemType Directory -Path $testRoot | Out-Null
    $env:GROK_HOME = Join-Path $testRoot 'custom-grok-home'
    # Substitute the download boundary only. All managed-file and native CLI
    # behavior runs through the installer using a real, isolated Grok profile.
    $installer = [IO.File]::ReadAllText((Join-Path $TestRepository 'install/install.ps1'))
    $tokens = $null
    $parseErrors = $null
    $ast = [Management.Automation.Language.Parser]::ParseInput($installer, [ref]$tokens, [ref]$parseErrors)
    Assert-True ($parseErrors.Count -eq 0) 'Installer parsing failed.'
    $download = $ast.Find({ param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $node.Name -eq 'Download' }, $true)
    Assert-True ($null -ne $download) 'Download boundary was absent.'
    $localDownload = @'
function Download([string]$Url, [string]$Destination) {
    $relative = $Url.Substring($base.Length + 1)
    Copy-Item -LiteralPath (Join-Path $TestRepository $relative) -Destination $Destination
}
'@
    $installer = $installer.Remove($download.Extent.StartOffset, $download.Extent.EndOffset - $download.Extent.StartOffset).Insert($download.Extent.StartOffset, $localDownload)
    $staged = Join-Path $testRoot 'install.ps1'
    [IO.File]::WriteAllText($staged, $installer, $utf8)
    Push-Location $testRoot
    try {
        & $staged -Agent grok
        $servers = & $grokCommand mcp list --json | ConvertFrom-Json
        Assert-True ($LASTEXITCODE -eq 0) 'Native server listing failed.'
        $connection = @($servers | Where-Object { $_.name -ceq 'content-factory' })
        Assert-True ($connection.Count -eq 1) 'Expected one ContentFactory server.'
        Assert-True ($connection[0].url -ceq 'https://content-factory.art/mcp') 'Wrong MCP endpoint.'
        Assert-True ($connection[0].scope -ceq 'user') 'Wrong MCP scope.'
        & (Join-Path $TestRepository 'tests/validate_skills.ps1') -RepositoryRoot $TestRepository -InstalledRoot (Join-Path $env:GROK_HOME 'skills') -InstalledManifest (Join-Path $env:GROK_HOME '.contentfactory/manifest.tsv') | Out-Null
        $inspection = & $grokCommand inspect --json | ConvertFrom-Json
        Assert-True ($LASTEXITCODE -eq 0) 'Native skill inspection failed.'
        Assert-True (@($inspection.skills | Where-Object { $_.name -ceq 'contentfactory' }).Count -eq 1) 'Grok did not discover the workflow skill.'

        # Native add is an upsert. An installer rerun must preserve a customized,
        # disabled server, including its exact configuration bytes.
        & $grokCommand mcp add --transport http --scope user content-factory https://example.invalid/custom-mcp | Out-Null
        Assert-True ($LASTEXITCODE -eq 0) 'Could not prepare customized connection.'
        & $grokCommand mcp disable content-factory | Out-Null
        Assert-True ($LASTEXITCODE -eq 0) 'Could not prepare disabled connection.'
        $config = Join-Path $env:GROK_HOME 'config.toml'
        $before = (Get-FileHash -LiteralPath $config).Hash
        & $staged -Agent grok
        Assert-True ((Get-FileHash -LiteralPath $config).Hash -ceq $before) 'Rerun replaced an existing MCP connection.'
        & $staged -Agent grok -Check
        Assert-True ((Get-FileHash -LiteralPath $config).Hash -ceq $before) 'Check changed MCP configuration.'

        $skill = Join-Path $env:GROK_HOME 'skills/contentfactory/SKILL.md'
        [IO.File]::AppendAllText($skill, "`nLocal customization.`n", $utf8)
        $customDigest = (Get-FileHash -LiteralPath $skill).Hash
        $conflict = $false
        try { & $staged -Agent grok -InstallOnly } catch { $conflict = $_.Exception.Message.StartsWith('Locally changed or missing managed file:') }
        Assert-True $conflict 'Expected local skill customization to block replacement.'
        Assert-True ((Get-FileHash -LiteralPath $skill).Hash -ceq $customDigest) 'Local skill customization was replaced.'

        # Each GROK_HOME has its own install state and can be installed separately.
        $env:GROK_HOME = Join-Path $testRoot 'second-grok-home'
        & $staged -Agent grok -InstallOnly
        Assert-True (Test-Path -LiteralPath (Join-Path $env:GROK_HOME 'skills/contentfactory/SKILL.md')) 'A second profile could not install.'
        Assert-True (!(Test-Path -LiteralPath (Join-Path $env:GROK_HOME 'config.toml'))) 'InstallOnly created an MCP connection.'
    } finally { Pop-Location }
    Write-Output 'PASS Grok installer, native MCP registration, skill discovery, reruns, check, local conflicts and isolated profiles.'
} finally {
    $env:GROK_HOME = $savedGrokHome
    $resolvedTestRoot = [IO.Path]::GetFullPath($testRoot)
    $temporaryRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath()).TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
    if (!$resolvedTestRoot.StartsWith($temporaryRoot, [StringComparison]::OrdinalIgnoreCase)) { throw 'Test cleanup path escaped the temporary directory.' }
    if (Test-Path -LiteralPath $resolvedTestRoot) { Remove-Item -LiteralPath $resolvedTestRoot -Recurse -Force }
}
