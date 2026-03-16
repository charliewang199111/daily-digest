# Install daily-digest skill with GitHub Pages support

$SkillPath = "C:\Users\Administrator\.openclaw\workspace\skills\daily-digest"
$TaskName = "OpenClaw-Daily-Digest"

Write-Host "========================================"
Write-Host "  Installing Daily Digest Skill"
Write-Host "  (GitHub Pages Version)"
Write-Host "========================================"
Write-Host ""

# 1. Verify skill files
Write-Host "1. Checking skill files..."
if (Test-Path "$SkillPath\generate-html.ps1") {
    Write-Host "   [OK] Skill scripts found"
} else {
    Write-Host "   [ERROR] Skill scripts not found!"
    exit 1
}

# 2. Check GitHub CLI
Write-Host ""
Write-Host "2. Checking GitHub CLI..."
try {
    $ghStatus = & gh auth status 2>&1
    if ($ghStatus -match "logged into") {
        Write-Host "   [OK] GitHub CLI is logged in"
    } else {
        Write-Host "   [WARN] GitHub CLI not logged in"
        Write-Host ""
        Write-Host "   Please run: gh auth login"
        Write-Host ""
    }
} catch {
    Write-Host "   [WARN] GitHub CLI not installed or not logged in"
    Write-Host ""
    Write-Host "   Install: winget install GitHub.cli"
    Write-Host "   Then run: gh auth login"
}

# 3. Create/update scheduled task
Write-Host ""
Write-Host "3. Creating scheduled task (daily at 09:00)..."
try {
    schtasks /Delete /TN $TaskName /F 2>$null | Out-Null
    
    $action = "powershell -ExecutionPolicy Bypass -File `"$SkillPath\generate-html.ps1`" -Date (Get-Date -Format 'yyyy-MM-dd')"
    schtasks /Create /TN $TaskName /TR $action /SC DAILY /ST 09:00 /RU SYSTEM /RL HIGHEST /F | Out-Null
    
    Write-Host "   [OK] Scheduled task created"
    Write-Host "   Task: $TaskName"
    Write-Host "   Schedule: Daily at 09:00"
} catch {
    Write-Host "   [ERROR] Failed: $_"
}

Write-Host ""
Write-Host "========================================"
Write-Host "  Installation Complete!"
Write-Host "========================================"
Write-Host ""
Write-Host "Next Steps:"
Write-Host ""
Write-Host "1. Login to GitHub (if not already):"
Write-Host "   gh auth login"
Write-Host ""
Write-Host "2. Create GitHub repo:"
Write-Host "   cd $SkillPath"
Write-Host "   gh repo create daily-digest --public --source=. --remote=origin"
Write-Host ""
Write-Host "3. Enable GitHub Pages:"
Write-Host "   Visit: https://github.com/YOUR_USERNAME/daily-digest/settings/pages"
Write-Host "   Select: main branch, /root folder"
Write-Host ""
Write-Host "4. Test run:"
Write-Host "   .\generate-html.ps1 -Push"
Write-Host ""
Write-Host "Manual run command:"
Write-Host "   .\generate-html.ps1"
Write-Host ""
Write-Host "Next auto-run: Tomorrow at 09:00"
Write-Host ""
