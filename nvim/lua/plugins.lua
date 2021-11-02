vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")

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
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"williamboman/nvim-lsp-installer",
	})

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

	use("projekt0n/github-nvim-theme")
	use("kyazdani42/nvim-tree.lua")

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
end)
