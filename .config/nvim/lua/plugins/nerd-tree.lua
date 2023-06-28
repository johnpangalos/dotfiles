return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  version = false,
  keys = {
    {
      "<C-n>",
      function()
        local api = require("nvim-tree.api")
        api.tree.toggle()
      end,
    },
  },
  opts = function()
    local api = require("nvim-tree.api")
    local silent = { silent = true }
    vim.keymap.set("n", "<leader>n", api.tree.focus, silent)

    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
          vim.cmd("quit")
        end
      end,
    })

    return {
      git = {
        enable = false,
      },
      sort_by = "case_sensitive",
      view = {
        adaptive_size = true,
      },
      renderer = {
        group_empty = true,
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
    }
  end,
}
