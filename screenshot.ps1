# screenshot.ps1 — take a full-page screenshot via Chrome headless
# Usage: .\screenshot.ps1 [url] [label]
# Example: .\screenshot.ps1 http://localhost:3000 hero

param(
  [string]$url   = "http://localhost:3000",
  [string]$label = ""
)

$chrome  = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$ssDir   = Join-Path $PSScriptRoot "temporary screenshots"
if (-not (Test-Path $ssDir)) { New-Item -ItemType Directory -Path $ssDir | Out-Null }

$n = 1
$suffix = if ($label) { "-$label" } else { "" }
while (Test-Path (Join-Path $ssDir "screenshot-$n$suffix.png")) { $n++ }
$out = Join-Path $ssDir "screenshot-$n$suffix.png"

& $chrome --headless=new --screenshot="$out" --window-size=1440,5000 --hide-scrollbars $url 2>$null
Start-Sleep -Seconds 3

if (Test-Path $out) {
  Write-Host "Screenshot saved: $out" -ForegroundColor Cyan
} else {
  Write-Host "Screenshot failed" -ForegroundColor Red
}
