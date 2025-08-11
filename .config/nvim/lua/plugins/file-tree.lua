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
      -- Replace indent-blankline.nvim and mini.indentscope
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
    keys = {
      -- Keep your existing <D-b> mapping with hidden files shown
      {
        "<D-b>",
        function()
          Snacks.explorer({ hidden = true })
        end,
        desc = "Explorer",
      },
      -- Add common explorer keymaps
      {
        "<leader>e",
        function()
          Snacks.explorer({ hidden = true })
        end,
        desc = "Explorer",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer.reveal()
        end,
        desc = "Explorer (reveal current file)",
      },
    },
  },
}
