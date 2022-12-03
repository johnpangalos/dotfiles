-- require("github-theme").setup({
-- 	theme_style = "dark_default",
-- })

require("catppuccin").setup()

local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
  update_interval = 200,
  set_dark_mode = function()
    vim.api.nvim_set_option("background", "dark")
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    vim.cmd([[colorscheme catppuccin]])
  end,
  set_light_mode = function()
    vim.api.nvim_set_option("background", "light")
    vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha
    vim.cmd([[colorscheme catppuccin]])
  end,
})

auto_dark_mode.init()
