vim.g.mapleader = ","

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
vim.o.mouse = "a"

vim.o.number = true

-- tabs / spacing
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.smarttab = true

-- use the normal ripgrep as it excludes .gitignore files keeping the --vimgrep
-- flag as it ensure compatibility with vim
vim.o.grepprg = "rg --vimgrep"

-- colors
vim.cmd([[ syntax enable ]])

vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/johnpangalos/wip.nvim",
})

-- formatter setup
require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

require("wip").setup()
