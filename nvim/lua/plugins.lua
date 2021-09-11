return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- General plugins
  use 'tpope/vim-sensible'

  -- Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Completion and linting
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'mhartington/formatter.nvim'
  use 'sainnhe/gruvbox-material'
end)
