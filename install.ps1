# Business Owner Workshops: installs Your 3 AI Bonuses for Claude Code (Windows).
$ErrorActionPreference = "Stop"
$repo = "https://raw.githubusercontent.com/LaughlinBusinessAdvisors/lba-ai-bonuses/main"
$dest = Join-Path $HOME ".claude\commands\lba"
New-Item -ItemType Directory -Force -Path $dest, (Join-Path $HOME "My Business Brain") | Out-Null
$bb = Join-Path $HOME "My Business Brain\.claude"
New-Item -ItemType Directory -Force -Path $bb | Out-Null
$set = Join-Path $bb "settings.json"
if (-not (Test-Path $set)) { '{"permissions":{"deny":["Read(~/.ssh/**)","Read(~/.aws/**)","Read(**/.env*)","Bash(rm:*)","Bash(curl:*)","PowerShell(Remove-Item:*)","PowerShell(Invoke-WebRequest:*)"]}}' | Set-Content -Encoding ascii $set }
foreach ($c in "start","teach","prove","build","customer","research","write","dump","organize","my","update") {
  Invoke-WebRequest -UseBasicParsing "$repo/commands/lba/$c.md" -OutFile (Join-Path $dest "$c.md")
}
Write-Host "Your 3 AI Bonuses are installed. Type: cd `"$HOME\My Business Brain`"  then: claude  then: /lba:start"
