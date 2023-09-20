vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local g = vim.g
local o = vim.o

g.mapleader = ","

o.hidden = true
o.splitright = true
o.splitbelow = true
o.clipboard = vim.o.clipboard .. "unnamedplus"
o.mouse = "a"
o.number = true
o.tabstop = 2
o.softtabstop = 0
o.expandtab = true
o.shiftwidth = 2
o.smarttab = true
o.completeopt = "menuone,noselect"
vim.cmd([[set shortmess+=c]])

vim.opt.termguicolors = true
vim.cmd([[syntax enable]])

-- Setup lazy vim https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    notify = false,
  },
  performance = {
    -- cache = {
    --   enabled = true,
    -- },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
