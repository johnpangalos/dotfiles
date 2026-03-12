#!/bin/zsh

defaults delete com.apple.dock persistent-apps 2>/dev/null
defaults delete com.apple.dock recent-apps 2>/dev/null

dock_item() {
  printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>' "$1"
}

defaults write com.apple.dock persistent-apps -array \
  "$(dock_item /Applications/Firefox.app)" \
  "$(dock_item /Applications/Ghostty.app)" \
  "$(dock_item /Applications/Discord.app)" \
  "$(dock_item /Applications/Bitwarden.app)" \
  "$(dock_item /System/Applications/System\ Settings.app)"

killall Dock
