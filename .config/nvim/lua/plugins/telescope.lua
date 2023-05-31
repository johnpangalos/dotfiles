return {
  {
    "nvim-telescope/telescope.nvim",
    commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false,
    config = function()
      local builtin = require("telescope.builtin")
      local theme = require("telescope.themes")
      local silent = { silent = true }

      vim.keymap.set("n", "<leader>t", function()
        builtin.find_files(theme.get_dropdown({
          find_command = { "rg", "--files", "--iglob=!.git/*", "-.", "--ignore" },
        }))
      end, silent)

      vim.keymap.set("n", "<leader>f", function()
        builtin.live_grep(theme.get_dropdown({ additional_args = { "-." } }))
      end, silent)

      vim.keymap.set("n", ";", function()
        builtin.buffers(theme.get_dropdown({ sort_mru = true, ignore_current_buffer = true }))
      end, silent)
    end,

    opts = {
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
          previewer = false,
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
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
