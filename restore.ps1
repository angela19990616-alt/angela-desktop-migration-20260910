param([string]$Root = (Join-Path $env:USERPROFILE 'AngelaProjects'))
$ErrorActionPreference = 'Stop'
$manifest = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw 'Install GitHub CLI, then run gh auth login.' }
& gh auth status 2>$null
if ($LASTEXITCODE -ne 0) { throw 'Run gh auth login with your GitHub account first.' }
New-Item -ItemType Directory -Force -Path $Root | Out-Null
$Root = (Resolve-Path -LiteralPath $Root).Path
foreach ($project in $manifest.projects) {
    if ($project.directory -notmatch '^[a-z0-9][a-z0-9-]*$') { throw 'Invalid project directory in manifest.' }
    $target = Join-Path $Root $project.directory
    if (Test-Path -LiteralPath $target) {
        $marker = Join-Path $target '.migration-verified.json'
        if ((Test-Path -LiteralPath $marker) -and ((Get-Content -LiteralPath $marker -Raw -Encoding UTF8 | ConvertFrom-Json).archiveSha256 -eq $project.sha256)) {
            $valid = $true
            foreach ($file in $project.files) {
                $path = Join-Path $target $file.path
                if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { $valid = $false; break }
                if ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $file.sha256) { $valid = $false; break }
            }
            if ($valid) { Write-Host "$($project.directory): already verified; skipped"; continue }
        }
        throw "Target exists and differs or is unverified: $target. Choose a new -Root; nothing was overwritten."
    }
    $work = Join-Path $Root ('.migration-' + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $work | Out-Null
    & gh release download $manifest.release --repo $manifest.repository --pattern $project.asset --dir $work
    if ($LASTEXITCODE -ne 0) { throw "Download failed. Retry later; partial files retained at $work" }
    $archive = Join-Path $work $project.asset
    if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant() -ne $project.sha256) { throw 'Archive checksum mismatch. Nothing extracted.' }
    $extract = Join-Path $work 'extracted'
    Expand-Archive -LiteralPath $archive -DestinationPath $extract
    $candidate = Join-Path $extract $project.directory
    if (-not (Test-Path -LiteralPath $candidate -PathType Container)) { throw 'Project root missing in archive.' }
    foreach ($file in $project.files) {
        if ($file.path -match '(^/|^[A-Za-z]:|(^|/)\.\.(/|$)|\\)') { throw 'Unsafe manifest path.' }
        $path = Join-Path $candidate $file.path
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Missing file: $($file.path)" }
        if ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $file.sha256) { throw "File checksum mismatch: $($file.path)" }
    }
    $actual = @(Get-ChildItem -LiteralPath $candidate -Recurse -Force -File)
    if ($actual.Count -ne @($project.files).Count) { throw 'Unexpected archive file count.' }
    @{ archiveSha256 = $project.sha256; sourceCommit = $project.sourceCommit; verifiedUtc = [DateTime]::UtcNow.ToString('o') } |
        ConvertTo-Json | Set-Content -LiteralPath (Join-Path $candidate '.migration-verified.json') -Encoding UTF8
    Move-Item -LiteralPath $candidate -Destination $target
    Write-Host "$($project.directory): files restored and verified. Runtime acceptance is still required."
}
