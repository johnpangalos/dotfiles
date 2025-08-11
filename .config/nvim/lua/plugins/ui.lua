return {
  {
    "echasnovski/mini.diff",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎", -- Same signs as your gitsigns config
          change = "▎",
          delete = "",
        },
      },
    },
  },
  -- Inline git blame
  {
    "f-person/git-blame.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      enabled = true,
      message_template = "      <author>, <date>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
  },
  -- Additional Snacks modules
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = {
        enabled = true,
        notify = true,
        size = 1.5 * 1024 * 1024, -- 1.5MB
      },
      quickfile = {
        enabled = true,
      },
      words = {
        enabled = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
