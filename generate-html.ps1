# Generate HTML Daily Digest

param([string]$Date, [switch]$Push)

if (-not $Date) { $Date = Get-Date -Format "yyyy-MM-dd" }
$DateObj = Get-Date $Date
$Time = (Get-Date).ToString("HH:mm")
$OutputDir = "$PSScriptRoot\output"
$HtmlFile = "$OutputDir\$Date.html"

if (-not (Test-Path $OutputDir)) { New-Item -ItemType Directory -Path $OutputDir | Out-Null }

Write-Host "Generating: $Date"

$Template = "$PSScriptRoot\template.html"
$Content = Get-Content $Template -Raw -Encoding UTF8
$Content = $Content -replace '{{DATE_CN}}', $DateObj.ToString('yyyy 年 M 月 d 日')
$Content = $Content -replace '{{TIME}}', $Time
$Content | Out-File -FilePath $HtmlFile -Encoding UTF8

Write-Host "OK: $HtmlFile"

if ($Push) {
  Set-Location "$PSScriptRoot"
  git add output/
  git commit -m "Daily: $Date"
  git push
  Write-Host "Pushed"
}