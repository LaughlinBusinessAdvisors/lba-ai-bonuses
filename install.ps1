# Business Owner Workshops: installs Your AI Bonuses for Claude Code (Windows).
# Adds files to %USERPROFILE%\.claude\commands\lba and makes the folder My Business Brain. Nothing else.
$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$repo = "https://raw.githubusercontent.com/LaughlinBusinessAdvisors/lba-ai-bonuses/main"
$dest = Join-Path $HOME ".claude\commands\lba"
$brain = Join-Path $HOME "My Business Brain"
New-Item -ItemType Directory -Force -Path $dest, $brain | Out-Null
$bb = Join-Path $brain ".claude"
New-Item -ItemType Directory -Force -Path $bb | Out-Null
$set = Join-Path $bb "settings.json"
if (-not (Test-Path $set)) {
  '{"permissions":{"deny":["Read(~/.ssh/**)","Read(~/.aws/**)","Read(**/.env*)","Bash(rm:*)","Bash(curl:*)","Bash(wget:*)","PowerShell(Remove-Item:*)","PowerShell(Invoke-WebRequest:*)","PowerShell(Invoke-RestMethod:*)"]}}' | Set-Content -Encoding ascii $set
}
foreach ($old in "handoff","week") { Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $dest "$old.md") }
foreach ($c in "start","teach","prove","build","customer","research","write","human","dump","organize","my","update") {
  try {
    Invoke-WebRequest -UseBasicParsing "$repo/commands/lba/$c.md" -OutFile (Join-Path $dest "$c.md")
  } catch {
    Write-Host "Couldn't download $c. Check your internet and try again."
    return
  }
}
# Make sure Windows can find Claude Code (Anthropic's installer asks owners to edit PATH by hand).
$bin = Join-Path $HOME ".local\bin"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (Test-Path (Join-Path $bin "claude.exe")) {
  if (-not (($userPath -split ";") -contains $bin)) {
    $newPath = if ([string]::IsNullOrEmpty($userPath)) { $bin } else { "$userPath;$bin" }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Fixed: Windows can now find Claude Code."
  }
  if (-not (($env:Path -split ";") -contains $bin)) { $env:Path = "$env:Path;$bin" }
} elseif (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Write-Host "Heads up: Claude Code isn't installed yet. Do step 2 in the lesson, then paste this line again."
}
Write-Host ""
Write-Host "   LBA"
Write-Host ""
Write-Host "Your AI Bonuses are installed."
Write-Host ""
Write-Host "Close this window and open a fresh PowerShell window. Then type these one at a time:"
Write-Host "  cd `"$brain`""
Write-Host "  claude"
Write-Host "  /lba:start"
