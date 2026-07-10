vim.g.mapleader = " "

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
vim.o.shiftwidth = 2

-- use the normal ripgrep as it excludes .gitignore files keeping the --vimgrep
-- flag as it ensure compatibility with vim
vim.o.grepprg = "rg --hidden --vimgrep"

-- colors
vim.cmd([[ syntax enable ]])

vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/johnpangalos/wip.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/f-person/auto-dark-mode.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/sindrets/diffview.nvim",
})

-- lsp setup
vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition()
end)

-- tree view
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1
-- vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- formatter setup
require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

require("wip").setup()

local snacks = require("snacks")

-- pickers
vim.keymap.set("n", "<Leader><space>", function()
  snacks.picker.files()
end)

vim.keymap.set("n", "<Leader>,", function()
  snacks.picker.buffers()
end)

vim.keymap.set("n", "<Leader>/", function()
  snacks.picker.grep()
end)

vim.keymap.set("n", "<Leader>e", function()
  snacks.explorer({ include = { "dist" } })
end)

-- git
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    -- jump between hunks
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { buffer = bufnr })

    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { buffer = bufnr })

    vim.keymap.set("n", "<Leader>gp", gitsigns.preview_hunk, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>gr", gitsigns.reset_hunk, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>ga", gitsigns.stage_hunk, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>gb", gitsigns.blame_line, { buffer = bufnr })
  end,
})

require("diffview").setup()

-- changed files picker
vim.keymap.set("n", "<Leader>gs", function()
  snacks.picker.git_status()
end)

-- hunk picker across the repo
vim.keymap.set("n", "<Leader>gh", function()
  snacks.picker.git_diff()
end)

-- PR-style review mode: file panel + side-by-side diff, unchanged code folded
vim.keymap.set("n", "<Leader>gd", function()
  local lib = require("diffview.lib")
  if lib.get_current_view() then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen")
  end
end)

-- Quit neovim when :q would leave only snacks windows (e.g. explorer)
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local wins = vim.api.nvim_list_wins()
    local non_snacks = 0
    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.bo[buf].filetype
      if not ft:find("^snacks_") then
        non_snacks = non_snacks + 1
      end
    end
    if non_snacks <= 1 then
      vim.cmd("qa")
    end
  end,
})

local autoDarkMode = require("auto-dark-mode")

autoDarkMode.setup({
  set_dark_mode = function()
    vim.cmd("colorscheme tokyonight-night")
  end,

  set_light_mode = function()
    vim.cmd("colorscheme tokyonight-day")
  end,
})
