return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "JoosepAlviste/nvim-ts-context-commentstring",
    },
    ---@type TSConfig
    opts = {
      parser_install_dir = "$HOME/.local/share/treesitter",
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "c",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "go",
        "html",
        "javascript",
        "json",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "proto",
        "query",
        "regex",
        "scala",
        "tsx",
        "typescript",
        "terraform",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      vim.opt.runtimepath:append("$HOME/.local/share/treesitter")
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
