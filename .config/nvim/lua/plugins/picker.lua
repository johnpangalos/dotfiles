return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {
      grep = {
        rg_glob = true,
        rg_opts = "--glob !.git -n --column --color=always --smart-case "
          .. "--type-add lockfiles:Cargo.lock --type-add lockfiles:*-lock.yaml "
          .. "--type-not lockfiles -. ",
      },
    },
    keys = {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      {
        ";",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader>t",
        "<cmd>FzfLua files<cr>",
        desc = "Search files",
      },
      {
        "<leader>f",
        "<cmd>FzfLua live_grep<cr>",
        desc = "Live grep",
      },
    },
  },
}
