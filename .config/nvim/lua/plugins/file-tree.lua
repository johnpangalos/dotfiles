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
    config = function(_, opts)
      require("snacks").setup(opts)

      -- Handle quitting when explorer is the last window
      -- https://github.com/folke/snacks.nvim/issues/1233
      vim.api.nvim_create_autocmd('QuitPre', {
        callback = function()
          local snacks_windows = {}
          local floating_windows = {}
          local windows = vim.api.nvim_list_wins()
          for _, w in ipairs(windows) do
            local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(w) })
            if filetype:match('snacks_') ~= nil then
              table.insert(snacks_windows, w)
            elseif vim.api.nvim_win_get_config(w).relative ~= '' then
              table.insert(floating_windows, w)
            end
          end
          if 1 == #windows - #floating_windows - #snacks_windows
              and vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative == ""
          then
            -- Should quit, so we close all Snacks windows.
            for _, w in ipairs(snacks_windows) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })
    end,
  },
}
