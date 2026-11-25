#!/bin/bash
# Business Owner Workshops: installs Your 3 AI Bonuses for Claude Code.
# Adds files to ~/.claude/commands/lba and makes the folder ~/My Business Brain. Nothing else.
set -e
REPO="${LBA_REPO:-https://raw.githubusercontent.com/LaughlinBusinessAdvisors/lba-ai-bonuses/main}"
DEST="$HOME/.claude/commands/lba"
mkdir -p "$DEST" "$HOME/My Business Brain"
for c in start teach prove handoff customer write dump week update; do
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
