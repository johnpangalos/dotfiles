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
      indent = {
        enabled = true,
        indent = {
          char = "│",
          only_scope = false,
          only_current = false,
        },
        scope = {
          enabled = true,
          char = "│",
          underline = false,
          only_current = false,
        },
        chunk = {
          enabled = false, -- Keep it simple like your original config
        },
        -- Replicate the filetype exclusions from your original config
        filter = function(buf)
          local excluded_fts = {
            "help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble",
            "lazy", "mason", "notify", "toggleterm", "lazyterm"
          }
          local ft = vim.bo[buf].filetype
          for _, excluded_ft in ipairs(excluded_fts) do
            if ft == excluded_ft then
              return false
            end
          end
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
      -- Replace gitsigns.nvim with statuscolumn (requires mini.diff for git change detection)
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" },
        right = { "fold", "git" },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
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
