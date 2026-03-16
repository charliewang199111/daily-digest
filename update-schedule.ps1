# Update scheduled task to post to Feishu

$SkillPath = "C:\Users\Administrator\.openclaw\workspace\skills\daily-digest"
$TaskName = "OpenClaw-Daily-Digest"

# Delete old task
schtasks /Delete /TN $TaskName /F 2>$null | Out-Null

# Create new task that runs the daily script
$action = "powershell -ExecutionPolicy Bypass -File `"$SkillPath\run-daily.ps1`""
schtasks /Create /TN $TaskName /TR $action /SC DAILY /ST 09:00 /RU SYSTEM /RL HIGHEST /F

Write-Host "Scheduled task updated!"
Write-Host "Task: $TaskName"
Write-Host "Schedule: Daily at 09:00"
Write-Host ""
Write-Host "Manual test: .\run-daily.ps1"
