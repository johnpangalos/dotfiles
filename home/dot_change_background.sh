#!/bin/sh

claude_theme() {
  CLAUDE_CONFIG="$HOME/.claude.json"

  if ! test -f "${CLAUDE_CONFIG}"; then
    echo "file ${CLAUDE_CONFIG} doesn't exist"
    return
  fi

  MODE=$1

  if [ "$MODE" = "light" ]; then
    TMP_FILE=$(mktemp)
    jq '.theme = "light"' "${CLAUDE_CONFIG}" > "$TMP_FILE" && mv "$TMP_FILE" "${CLAUDE_CONFIG}"
    echo "Claude theme switched to light."
  else
    TMP_FILE=$(mktemp)
    jq 'del(.theme)' "${CLAUDE_CONFIG}" > "$TMP_FILE" && mv "$TMP_FILE" "${CLAUDE_CONFIG}"
    echo "Claude theme switched to dark."
  fi
}

if ( ! $(defaults read -g AppleInterfaceStyle &>/dev/null)); then
  claude_theme light
else
  claude_theme dark
fi
