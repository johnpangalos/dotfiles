return {
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        -- Load lazy.nvim types
        { path = "lazy.nvim", words = { "LazyVim" } },
        -- Load Snacks.nvim types  
        { path = "snacks.nvim", words = { "Snacks" } },
        -- Load other plugin types as needed
        { path = "mini.nvim", words = { "MiniDiff", "MiniIndentscope" } },
      },
    },
  },
}
