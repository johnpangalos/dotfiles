#!/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

if ! (( $+commands[node] )) && (( $+commands[fnm] )); then
  echo "Node not found, installing..."
  fnm install --lts
  fnm default lts-latest
  eval "$(fnm env)"

  echo "Installing pnpm"
  curl -fsSL https://get.pnpm.io/install.sh | sh -
else
  echo "Node found, skipping install."
fi
