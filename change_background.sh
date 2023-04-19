# https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
alacritty_theme() {
  if ! test -f $HOME/repos/dotfiles/colors.yml; then
    echo "file ~/repos/dotfiles/colors.yml doesn't exist"
    return
  fi

  THEME=$1
  sed  -i "" -e "s#^colors: \*.*#colors: *$THEME#g" $HOME/repos/dotfiles/colors.yml

  echo "switched to $THEME."
}


if ( ! $(defaults read -g AppleInterfaceStyle &>/dev/null)); then
  alacritty_theme catppuchin_latte 
else
  alacritty_theme catppuchin_mocha 
fi
