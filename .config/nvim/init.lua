vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local g = vim.g
local o = vim.o

g.mapleader = ","

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  "gzip",
  "man",
  "matchit",
  "matchparen",
  "shada_plugin",
  "tarPlugin",
  "tar",
  "zipPlugin",
  "zip",
  "netrwPlugin",
}

for i = 1, 10 do
  g["loaded_" .. disabled_built_ins[i]] = 1
end

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

require("index")
