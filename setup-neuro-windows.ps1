param([Parameter(Mandatory=$true)][string]$Project)
$ErrorActionPreference = 'Stop'
$Project = (Resolve-Path -LiteralPath $Project).Path
if (-not (Test-Path -LiteralPath (Join-Path $Project 'ssvep.py'))) { throw 'Select the restored neuro-harbor directory.' }
if (-not (Get-Command py -ErrorAction SilentlyContinue)) { throw 'Install Python 3.11 from python.org with the Python launcher.' }
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { throw 'Install Node.js first.' }
Push-Location $Project
try {
    if (-not (Test-Path -LiteralPath '.venv')) {
        & py -3.11 -m venv .venv
        if ($LASTEXITCODE -ne 0) { throw 'Python 3.11 virtual environment creation failed.' }
    }
    $python = Join-Path $Project '.venv\Scripts\python.exe'
    if (-not (Test-Path -LiteralPath $python)) { throw 'Existing .venv is not a Windows environment. Preserve it and select a fresh project copy.' }
    & $python -m pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) { throw 'Python dependency installation failed.' }
    & npm.cmd ci --ignore-scripts --no-audit --no-fund
    if ($LASTEXITCODE -ne 0) { throw 'Node dependency installation failed.' }
    New-Item -ItemType Directory -Force -Path web\vendor | Out-Null
    Copy-Item -LiteralPath node_modules\three\build\three.module.js -Destination web\vendor\three.module.js
    Copy-Item -LiteralPath node_modules\three\build\three.core.js -Destination web\vendor\three.core.js
    & $python -c 'import numpy, scipy, aiohttp, pylsl; print("Python and LSL imports passed")'
    if ($LASTEXITCODE -ne 0) { throw 'LSL import failed; inspect the official pylsl Windows installation requirements.' }
    & node --test tests/control.test.mjs tests/ssvep-surface.test.mjs tests/ssvep.test.mjs
    if ($LASTEXITCODE -ne 0) { throw 'Browser code tests failed.' }
    & $python -m unittest discover -s tests -p 'test_*.py'
    if ($LASTEXITCODE -ne 0) { throw 'Python tests failed.' }
    Write-Host 'Setup complete. Start .venv\Scripts\python.exe server.py, then open http://127.0.0.1:8765/.'
    Write-Host 'Actual OpenBCI/LSL samples and user controls still need Windows acceptance.'
} finally { Pop-Location }
