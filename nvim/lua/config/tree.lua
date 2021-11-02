local map = require("utils").map
local o = vim.o

local silent = { silent = true }

-- Navigate buffers and repos
map("n", "<c-n>", [[<cmd>NvimTreeToggle<cr>]], silent)
map("n", "<leader-r>", [[<cmd>NvimTreeRefresh<cr>]], silent)


require("nvim-tree").setup({
	auto_close = true,
})
