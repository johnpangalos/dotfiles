local map = require("utils").map
--
--
-- -- Exit Vim if NERDTree is the only window remaining in the only tab.
-- vim.cmd(
--   [[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NvimTree') && b:NvimTree.isTabTree() | quit | endif ]]
-- )
--
-- -- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
-- vim.cmd(
-- 	[[ autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif]]
-- )

require("nvim-tree").setup({
  git = {
    enable = false,
  },
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
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
  filters = {
    dotfiles = true,
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
