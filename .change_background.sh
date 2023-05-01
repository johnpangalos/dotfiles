#!/bin/sh

COLORS_FILE=$HOME/.dotfiles/colors.yml

# https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
alacritty_theme() {
  if ! test -f "${COLORS_FILE}"; then
    echo "file ${COLORS_FILE} doesn't exist"
    return
  fi

  THEME=$1
  sed  -i "" -e "s#^colors: \*.*#colors: *$THEME#g" ${COLORS_FILE}

  echo "switched to $THEME."
}


if ( ! $(defaults read -g AppleInterfaceStyle &>/dev/null)); then
  alacritty_theme catppuchin_latte 
else
  alacritty_theme catppuchin_mocha 
fi
