# Daily Digest - Auto Run with Knowledge Base Update
# Scheduled to run at 9:00 AM daily

param([string]$Date)

if (-not $Date) { $Date = Get-Date -Format "yyyy-MM-dd" }
$DateObj = Get-Date $Date
$DateCN = $DateObj.ToString("yyyy 年 M 月 d 日")
$Time = (Get-Date).ToString("HH:mm")

Write-Host "Generating daily digest for $DateCN..."

# Generate HTML
$OutputDir = "$PSScriptRoot\output"
if (-not (Test-Path $OutputDir)) { New-Item -ItemType Directory -Path $OutputDir | Out-Null }

$Template = "$PSScriptRoot\template.html"
$Content = Get-Content $Template -Raw -Encoding UTF8
$Content = $Content -replace '{{DATE_CN}}', $DateCN
$Content = $Content -replace '{{TIME}}', $Time
$HtmlFile = "$OutputDir\$Date.html"
$Content | Out-File -FilePath $HtmlFile -Encoding UTF8

Write-Host "Generated: $HtmlFile"

# Update knowledge base
$KnowledgeDir = "$PSScriptRoot\knowledge"
$KnowledgeFile = "$KnowledgeDir\$Date.md"

$DailyLog = @"
# 学习日志 - $DateCN

## 数据来源
- 各平台官方公告
- Reddit/Quora 用户讨论
- YouTube 美妆博主
- 第三方研究机构

## 今日重点
- [待手动补充]

## 待跟进
- [待补充]

---
*自动生成时间：$Time*
"@

$DailyLog | Out-File -FilePath $KnowledgeFile -Encoding UTF8
Write-Host "Knowledge log: $KnowledgeFile"

# Commit and push to GitHub
Set-Location "$PSScriptRoot"
git add output/ knowledge/
git commit -m "Daily: $Date"
git push

# GitHub Pages URL
$PagesUrl = "https://charliewang199111.github.io/daily-digest/output/$Date.html"

Write-Host "GitHub Pages URL: $PagesUrl"
Write-Host ""
Write-Host "Daily digest ready!"
