local map = require("utils").map

require("nvim-tree").setup({
  git = {
    enable = false,
  },
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        folder = {
          arrow_open = "-",
          arrow_closed = ">",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})

map("n", "<C-n>", [[<cmd>NvimTreeToggle<cr>]], silent)
map("n", "<leader>n", [[<cmd>NvimTreeFocus<cr>]], silent)

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})
