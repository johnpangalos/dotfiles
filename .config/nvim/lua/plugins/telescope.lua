return {
  {
    "nvim-telescope/telescope.nvim",
    version = "v1.1.0",
    config = function()
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local silent = { silent = true }

      vim.keymap.set("n", "<leader>t", function()
        builtin.find_files(themes.get_dropdown({ hidden = true }))
      end, silent)

      vim.keymap.set("n", "<leader>f", function()
        builtin.live_grep(themes.get_dropdown({ additional_args = { "-." } }))
      end, silent)

      vim.keymap.set("n", ";", function()
        builtin.buffers(themes.get_dropdown({ show_all_buffers = true }))
      end, silent)
    end,

    opts = function()
      return {
        defaults = {
          layout_strategy = "flex",
          scroll_strategy = "cycle",
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
        pickers = {
          lsp_references = { theme = "dropdown" },
          lsp_code_actions = { theme = "dropdown" },
          lsp_definitions = { theme = "dropdown" },
          lsp_implementations = { theme = "dropdown" },
          buffers = {
            sort_lastused = true,
            previewer = false,
          },
          find_files = {
            disable_devicons = true,
          },
          file_browser = {
            disable_devicons = true,
          },
          live_grep = {
            disable_devicons = true,
          },
        },
        file_ignore_patterns = {
          "dist/.*",
          "%.git/.*",
          "%.vim/.*",
          "node_modules/.*",
          "%.idea/.*",
          "%.vscode/.*",
          "%.history/.*",
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
