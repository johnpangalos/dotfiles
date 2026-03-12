#!/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

if ! (( $+commands[node] )) && (( $+commands[mise] )); then
  echo "Node not found, installing via mise..."
  mise install node@lts
  mise use --global node@lts
  eval "$(mise activate zsh)"

  echo "Enabling corepack and installing pnpm..."
  corepack enable
  corepack prepare pnpm@latest --activate
else
  echo "Node found, skipping install."
fi
