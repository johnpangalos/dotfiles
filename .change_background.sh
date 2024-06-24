#!/bin/sh

COLORS_FILE=$HOME/.dotfiles/.config/helix/config.toml

# https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
alacritty_theme() {
  if ! test -f "${COLORS_FILE}"; then
    echo "file ${COLORS_FILE} doesn't exist"
    return
  fi

  THEME=$1
  sed -i '' -e "s#^theme = .*#theme = \"$THEME\"#g" ${COLORS_FILE}

  # make sure helix updates
  pkill -USR1 hx

  echo "switched to $THEME."
}


if ( ! $(defaults read -g AppleInterfaceStyle &>/dev/null)); then
  alacritty_theme catppuccin_latte 
else
  alacritty_theme catppuccin_mocha 
fi
