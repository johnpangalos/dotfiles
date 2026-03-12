#!/bin/zsh

PLIST="$HOME/Library/LaunchAgents/ke.bou.dark-mode-notify.plist"

if [ -f "$PLIST" ]; then
  echo "Loading dark-mode-notify LaunchAgent..."
  launchctl unload -w "$PLIST" 2>/dev/null
  launchctl load -w "$PLIST"
  echo "dark-mode-notify LaunchAgent loaded."
else
  echo "dark-mode-notify plist not found, skipping."
fi
