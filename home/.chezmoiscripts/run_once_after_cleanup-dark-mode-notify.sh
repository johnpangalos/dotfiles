#!/bin/zsh

PLIST="$HOME/Library/LaunchAgents/ke.bou.dark-mode-notify.plist"
SWIFT="$HOME/.config/dark-mode-notify/dark-mode-notify.swift"
SCRIPT="$HOME/.change_background.sh"

if [ -f "$PLIST" ]; then
  echo "Unloading dark-mode-notify LaunchAgent..."
  launchctl bootout "gui/$(id -u)/ke.bou.dark-mode-notify" 2>/dev/null
  rm -f "$PLIST"
fi

rm -f "$SWIFT" "$SCRIPT"
rmdir "$HOME/.config/dark-mode-notify" 2>/dev/null

echo "dark-mode-notify cleanup complete."
