#!/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

if ! (( $+commands[node] )) && (( $+commands[fnm] )); then
  echo "Node not found, installing..."
  fnm install --lts
  fnm default lts-latest
  eval "$(fnm env)"

  echo "Enabling corepack and installing pnpm..."
  corepack enable
  corepack prepare pnpm@latest --activate
else
  echo "Node found, skipping install."
fi
