# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS setup and configuration management. The repository contains configuration files for development tools and a comprehensive setup script for bootstrapping a new macOS system.

## Key Commands

### Setup and Bootstrap
- **Initial setup**: `./setup-mac.zsh` - Interactive script to bootstrap a new macOS system
- **Re-run dotfiles symlinks**: Navigate to `~/.dotfiles` and run the dotfiles reset section of the setup script

### Neovim Development
- **Format files**: `<leader>j` in Neovim (uses conform.nvim with format_on_save enabled)
- **LSP commands**: Standard LSP keybindings with `,` as leader key
  - `gd` - Go to definition
  - `<leader>cd` - Rename symbol
  - `<leader>e` - Open diagnostic float
- **Code formatting**: Automatic on save via conform.nvim with language-specific formatters:
  - Lua: stylua
  - TypeScript/JavaScript: prettierd
  - Go: gofmt
  - Shell: shfmt

## Architecture and Organization

### Configuration Structure
The dotfiles are organized under `.config/` following XDG Base Directory specification:

- **Neovim**: `.config/nvim/` - Lua-based configuration using lazy.nvim plugin manager
  - Plugin system: Individual plugin files in `lua/plugins/`
  - Main config: `init.lua` with lazy.nvim setup
  - Language servers: Configured via mason.nvim and nvim-lspconfig

- **Shell**: `.config/sheldon/` - Zsh plugin management via sheldon
  - Uses geometry theme, syntax highlighting, and FZF key bindings
  - Includes git and kubectl plugins from oh-my-zsh

- **Terminal**: `.config/ghostty/` - Ghostty terminal emulator configuration
  - Uses Catppuccin Mocha theme
  - Includes custom theme files in `themes/` subdirectory

### System Integration
- **Dark mode integration**: Custom dark-mode-notify binary with LaunchAgent plist
- **Symlink management**: Setup script creates symlinks from `~/.dotfiles` to home directory
- **Package management**: Homebrew for system packages, fnm for Node.js, pnpm for Node packages

### Development Tools Configuration
- **LSP Setup**: Mason.nvim ensures installation of language servers (gopls, vtsls, lua_ls, json-lsp)
- **Conflict resolution**: Automatic detection and disabling of conflicting LSPs (Deno vs TypeScript)
- **Formatting**: Language-specific formatters with trim_whitespace and trim_newlines
- **Code completion**: Native Neovim LSP completion enabled

### Setup Script Behavior
The `setup-mac.zsh` script is interactive and modular:
- Installs Homebrew and essential CLI tools
- Sets up Node.js via fnm with latest LTS
- Configures SSH keys and GitHub CLI authentication
- Installs and configures the dark mode notification system
- Resets macOS Dock with specified applications
- Creates symlinks for configuration files (currently nvim, sheldon, ghostty)

Note: Some configuration files are commented out in the symlink section and may need manual setup.