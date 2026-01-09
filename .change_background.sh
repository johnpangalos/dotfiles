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

claude_theme() {
  CLAUDE_CONFIG="$HOME/.claude.json"

  if ! test -f "${CLAUDE_CONFIG}"; then
    echo "file ${CLAUDE_CONFIG} doesn't exist"
    return
  fi

  MODE=$1

  if [ "$MODE" = "light" ]; then
    # Set theme to "light"
    TMP_FILE=$(mktemp)
    jq '.theme = "light"' "${CLAUDE_CONFIG}" > "$TMP_FILE" && mv "$TMP_FILE" "${CLAUDE_CONFIG}"
    echo "Claude theme switched to light."
  else
    # Remove theme property for dark mode (default)
    TMP_FILE=$(mktemp)
    jq 'del(.theme)' "${CLAUDE_CONFIG}" > "$TMP_FILE" && mv "$TMP_FILE" "${CLAUDE_CONFIG}"
    echo "Claude theme switched to dark."
  fi
}


if ( ! $(defaults read -g AppleInterfaceStyle &>/dev/null)); then
  alacritty_theme ayu_light
  claude_theme light
else
  alacritty_theme ayu_dark
  claude_theme dark
fi
