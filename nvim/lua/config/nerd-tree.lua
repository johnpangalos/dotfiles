local map = require("utils").map

map("n", "<C-n>", [[<cmd>NERDTreeToggle<cr>]], silent)
map("n", "<leader>n", [[<cmd>NERDTreeFocus<cr>]], silent)

-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd(
	[[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif ]]
)

-- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
vim.cmd(
	[[ autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif]]
)
