return {
  {
    "editorconfig/editorconfig-vim",
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- {
  --   "folke/neodev.nvim",
  --   opts = {
  --     debug = true,
  --     experimental = {
  --       pathStrict = true,
  --     },
  --     library = {
  --       runtime = "~/projects/neovim/runtime/",
  --     },
  --   },
  -- },
}
