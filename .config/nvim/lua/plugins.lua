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

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    run = ":TSUpdate",
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use("nvim-lualine/lualine.nvim")
  use({ "kyazdani42/nvim-tree.lua" })

  use("elvessousa/sobrio")

  use({ "catppuccin/nvim", as = "catppuccin" })
  use("f-person/auto-dark-mode.nvim")
  use("editorconfig/editorconfig-vim")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
