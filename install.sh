#!/bin/bash
# Business Owner Workshops: installs Your 3 AI Bonuses for Claude Code.
# Adds files to ~/.claude/commands/lba and makes the folder ~/My Business Brain. Nothing else.
set -e
REPO="${LBA_REPO:-https://raw.githubusercontent.com/LaughlinBusinessAdvisors/lba-ai-bonuses/main}"
DEST="$HOME/.claude/commands/lba"
mkdir -p "$DEST" "$HOME/My Business Brain"
mkdir -p "$HOME/My Business Brain/.claude"
S="$HOME/My Business Brain/.claude/settings.json"
if [ ! -f "$S" ]; then
cat > "$S" <<'JSON'
{"permissions":{"deny":["Read(~/.ssh/**)","Read(~/.aws/**)","Read(**/.env*)","Read(~/Library/Keychains/**)","Bash(rm:*)","Bash(curl:*)","Bash(wget:*)","Bash(sudo:*)"]}}
JSON
fi
rm -f "$DEST/handoff.md" "$DEST/week.md"
for c in start teach prove build customer research write dump organize my update; do
  curl -fsSL "$REPO/commands/lba/$c.md" -o "$DEST/$c.md" || { echo "Couldn't download $c. Check your internet and try again."; exit 1; }
done
cat <<'ART'

   ██╗      ██████╗   █████╗
   ██║      ██╔══██╗ ██╔══██╗
   ██║      ██████╔╝ ███████║
   ██║      ██╔══██╗ ██╔══██║
   ███████╗ ██████╔╝ ██║  ██║
   ╚══════╝ ╚═════╝  ╚═╝  ╚═╝

ART
echo "Your 3 AI Bonuses are installed."; echo ""
echo "Next, type these one at a time:"; echo '  cd ~/"My Business Brain"'; echo "  claude"; echo "  /lba:start"
