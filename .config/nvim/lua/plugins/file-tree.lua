return {
  -- Mini.diff for git change detection (used by Snacks statuscolumn)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- Replace dressing.nvim functionality
      input = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true, -- Show hidden files by default
          }
        }
      },
      explorer = {
        replace_netrw = true,
      },
    },
    keys = {
      -- Keep your existing <D-b> mapping with hidden files shown
      {
        "<D-b>",
        function()
          Snacks.explorer({ hidden = true })
        end,
        desc = "Explorer",
      },
    },
  },
}
