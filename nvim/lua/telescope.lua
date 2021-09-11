local telescope = require('telescope.builtin')
local map = require('utils').map

local silent = { silent = true }

-- Navigate buffers and repos
map('n', ';', [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
map('n', '<leader>t', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>f', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
