vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("lewis6991/impatient.nvim")

  -- Search
  use({
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "telescope-fzf-native.nvim",
      },
      wants = {
        "popup.nvim",
        "plenary.nvim",
        "telescope-fzf-native.nvim",
      },
    },

    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
  })

  -- Completion and linting

  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  })

  use({ "simrat39/rust-tools.nvim" })

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    run = ":TSUpdate",
  })

  use("mhartington/formatter.nvim")

  use("nvim-lualine/lualine.nvim")
  use({ "kyazdani42/nvim-tree.lua", })

  use("elvessousa/sobrio")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
end)
