# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository for macOS, managed by [chezmoi](https://www.chezmoi.io/).

## Key Commands

- **Bootstrap a new system**: `chezmoi init --apply https://github.com/johnpangalos/dotfiles.git`
- **Sync/apply changes**: `chezmoi apply`
- **Preview changes**: `chezmoi diff`
- **Add a new dotfile**: `chezmoi add ~/.some-config`
- **Edit a managed file**: `chezmoi edit ~/.config/nvim/init.lua`
- **Format Lua files**: `stylua` (2-space indent, spaces not tabs)
- **Format shell scripts**: `shfmt`

## Architecture

### Chezmoi Layout

Uses `.chezmoiroot` pointing to `home/` — all managed dotfiles live under `home/` with chezmoi naming conventions (`dot_`, `private_dot_config/`). Bootstrap scripts are in `home/.chezmoiscripts/` as `run_once` scripts. Brew packages are declared in `Brewfile` at the repo root.

Machine-specific values (name, email) are prompted once during `chezmoi init` via `home/.chezmoi.toml.tmpl`.

### Configuration (targets `~/.config/`)

- **Neovim** (`private_dot_config/nvim/`): Single `init.lua` using native `vim.pack.add` for plugin management (not lazy.nvim). LSP configs are individual files in `lsp/` directory (e.g., `lsp/gopls.lua`, `lsp/tsgo.lua`). No mason.nvim — LSP servers are expected to be installed externally.
- **Shell** (`private_dot_config/sheldon/`): Zsh plugin management via sheldon with geometry theme, deferred syntax highlighting, oh-my-zsh git/kubectl plugins, and fzf key bindings.
- **Ghostty** (`private_dot_config/ghostty/`): TokyoNight theme (dark/light auto-switching). Legacy Catppuccin theme files exist in `themes/` but are not active.
- **Dark mode** (`private_dot_config/dark-mode-notify/`): Swift script that watches macOS appearance changes and updates Claude Code theme via `~/.change_background.sh`. Runs as a LaunchAgent.

### Neovim Details

- **Leader key**: `<space>` (not comma)
- **Key bindings**:
  - `gd` — Go to definition (LSP)
  - `<leader><space>` — Smart file picker (snacks.nvim)
  - `<leader>,` — Buffer picker
  - `<leader>/` — Grep picker
  - `<leader>e` — File explorer (snacks.nvim)
- **Formatting**: conform.nvim with `format_on_save` enabled, LSP fallback
- **Theme**: Ayu (Shatur/neovim-ayu) with auto-dark-mode.nvim (dark/light switching)
- **Plugins**: conform.nvim, nvim-lspconfig, nvim-treesitter, snacks.nvim, neovim-ayu, auto-dark-mode.nvim, wip.nvim

### Toolchain

- **Package manager**: Homebrew (packages declared in `Brewfile`)
- **Node.js**: fnm (with corepack enabled)
- **Node packages**: pnpm (never npm)
- **Runtime version manager**: mise (aliased as `asdf`)
- **Editor**: neovim (aliased as `vim`)
- **Shell**: zsh with vi bindings

### Coding Style

- 2-space indentation, spaces (not tabs), LF line endings
- Lua: 2-space indent via stylua
