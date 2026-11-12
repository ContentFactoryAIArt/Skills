param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$InstalledRoot,
    [string]$InstalledManifest
)
$ErrorActionPreference = 'Stop'
$utf8 = [Text.Encoding]::UTF8
$repo = [IO.Path]::GetFullPath($RepositoryRoot)
$skillsRoot = Join-Path $repo 'skills'
$manifestPath = Join-Path $repo 'manifest.tsv'
$records = [IO.File]::ReadAllLines($manifestPath, $utf8)
if ($records[0] -cnotmatch '^version\t([0-9]+\.[0-9]+\.[0-9]+)$') { throw 'Invalid manifest version.' }
$version = $Matches[1]
$paths = @{}
$skillNames = @{}
$fileCount = 0
$linkCount = 0
$results = @()
foreach ($record in $records[1..($records.Length - 1)]) {
    $parts = $record.Split("`t")
    if ($parts.Length -ne 3 -or $parts[0] -cne 'file' -or $parts[1] -cnotmatch '^[a-f0-9]{64}$') { throw 'Invalid manifest record.' }
    $relative = $parts[2]
    if ($relative -cnotmatch '^[a-z0-9]+(-[a-z0-9]+)*/[A-Za-z0-9_./-]+$' -or $relative.Split('/') -contains '..' -or $relative.Split('/') -contains '.') { throw "Unsafe manifest path: $relative" }
    if ($paths.ContainsKey($relative)) { throw "Duplicate manifest path: $relative" }
    $paths[$relative] = $true
    $source = Join-Path $skillsRoot $relative
    if (!(Test-Path -LiteralPath $source -PathType Leaf)) { throw "Missing source: $relative" }
    if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash.ToLowerInvariant() -cne $parts[1]) { throw "Source digest mismatch: $relative" }
    if ($InstalledRoot) {
        $installed = Join-Path $InstalledRoot $relative
        if (!(Test-Path -LiteralPath $installed -PathType Leaf)) { throw "Missing installed file: $relative" }
        if ((Get-FileHash -LiteralPath $installed -Algorithm SHA256).Hash.ToLowerInvariant() -cne $parts[1]) { throw "Installed digest mismatch: $relative" }
    }
    $fileCount++
    if ([IO.Path]::GetExtension($source) -ceq '.md') {
        $content = [IO.File]::ReadAllText($source, $utf8)
        if ($content.Contains("`r")) { throw "Managed Markdown must use LF to preserve published digests: $relative" }
        if ($content.Contains([char]0xFFFD)) { throw "Invalid Unicode replacement character: $relative" }
        if ($content -match '(?m)^\s*\[TODO:[^\n]*\]\s*$') { throw "Unfinished scaffold: $relative" }
        foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')) {
            $target = $match.Groups[1].Value
            if ($target -match '^(https?:|#|mailto:)') { continue }
            $target = ($target -split '#', 2)[0]
            $resolved = [IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $source) $target))
            if (!$resolved.StartsWith($skillsRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) { throw "Reference leaves skill bundle: $relative -> $target" }
            if (!(Test-Path -LiteralPath $resolved -PathType Leaf)) { throw "Broken reference: $relative -> $target" }
            $referenceRelative = $resolved.Substring($skillsRoot.Length + 1).Replace('\', '/')
            # All managed targets must travel in the manifest, not just exist in a checkout.
            if (!$records.Where({ $_.EndsWith("`t" + $referenceRelative, [StringComparison]::Ordinal) }).Count) { throw "Unpackaged reference: $referenceRelative" }
            $linkCount++
        }
        if ([IO.Path]::GetFileName($source) -ceq 'SKILL.md') {
            if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---') { throw "Missing frontmatter: $relative" }
            $frontmatter = $Matches[1]
            if ($frontmatter -notmatch '(?m)^name: ([a-z0-9]+(?:-[a-z0-9]+)*)\s*$') { throw "Invalid name: $relative" }
            $name = $Matches[1]
            if ($name.Length -gt 64 -or $name -cne $relative.Split('/')[0]) { throw "Skill/folder mismatch: $relative" }
            if ($frontmatter -notmatch '(?m)^description: (.+)$') { throw "Missing description: $relative" }
            $description = $Matches[1].Trim()
            if ($description.Length -gt 1024 -or $description -match '[<>]') { throw "Invalid description: $relative" }
            foreach ($line in $frontmatter.Split("`n")) {
                if ($line -notmatch '^(name|description|license|allowed-tools|metadata):' -and $line.Trim()) { throw "Unsupported frontmatter in $relative" }
            }
            $skillNames[$name] = $true
            $results += [ordered]@{ skill = $name; words = @([regex]::Matches($content, '\S+')).Count }
        }
    }
}
foreach ($name in $skillNames.Keys) {
    $directory = Join-Path $skillsRoot $name
    foreach ($file in Get-ChildItem -LiteralPath $directory -File -Recurse) {
        $relative = $file.FullName.Substring($skillsRoot.Length + 1).Replace('\', '/')
        if (!$paths.ContainsKey($relative)) { throw "Unpackaged skill resource: $relative" }
    }
}
if ($InstalledManifest) {
    if (!(Test-Path -LiteralPath $InstalledManifest -PathType Leaf)) { throw 'Installed manifest is absent.' }
    if ((Get-FileHash -LiteralPath $manifestPath).Hash -cne (Get-FileHash -LiteralPath $InstalledManifest).Hash) { throw 'Installed manifest differs from source.' }
}
[ordered]@{ status = 'PASS'; version = $version; skillCount = $skillNames.Count; managedFiles = $fileCount; localReferences = $linkCount; installedCompared = [bool]$InstalledRoot; skills = $results } | ConvertTo-Json -Depth 5
