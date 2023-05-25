return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      options = {
        icons_enabled = false,
        --   icons_enabled = false,
        --   theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    }
  end,
}
