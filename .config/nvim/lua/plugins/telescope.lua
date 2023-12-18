return {
  {
    lazy = true,
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    keys = {
      {
        "<leader>t",
        function()
          local builtin = require("telescope.builtin")
          local theme = require("telescope.themes")
          builtin.find_files(theme.get_dropdown({
            find_command = { "rg", "--files", "--glob=!.git", "-.", "--ignore" },
          }))
        end,
      },
      {
        "<leader>f",
        function()
          local builtin = require("telescope.builtin")
          local theme = require("telescope.themes")
          builtin.live_grep(theme.get_dropdown({
            additional_args = {
              "--glob",
              "!.git",
              "--type-add",
              "lockfiles:*-lock.yaml",
              "--type-add",
              "lockfiles:Cargo.lock",
              "--type-not",
              "lockfiles",
              "-.",
            },
          }))
        end,
      },
      {
        "<leader>s",
        function()
          local builtin = require("telescope.builtin")
          local theme = require("telescope.themes")
          builtin.lsp_document_symbols(theme.get_ivy())
        end,
      },
      {
        ";",
        function()
          local builtin = require("telescope.builtin")
          local theme = require("telescope.themes")
          builtin.buffers(theme.get_dropdown({ preview = false, ignore_current_buffer = true, sort_mru = true }))
        end,
      },
      {
        "gr",
        function()
          local builtin = require("telescope.builtin")
          local theme = require("telescope.themes")
          builtin.lsp_references(theme.get_ivy())
        end,
      },
    },
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
    lazy = true,
    build = "make",
    version = false,
    branch = "main",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
