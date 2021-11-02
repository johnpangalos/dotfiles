local map = require("utils").map
local telescope = require("telescope")

telescope.setup({
	defaults = {
		layout_strategy = "flex",
		scroll_strategy = "cycle",
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
	pickers = {
		lsp_references = { theme = "dropdown" },
		lsp_code_actions = { theme = "dropdown" },
		lsp_definitions = { theme = "dropdown" },
		lsp_implementations = { theme = "dropdown" },
		buffers = {
			sort_lastused = true,
			previewer = false,
		},
		find_files = {
			disable_devicons = true,
		},
		file_browser = {
			disable_devicons = true,
		},
	},
})

-- Extensions
telescope.load_extension("fzf")

local silent = { silent = true }

-- Navigate buffers and repos
map("n", ";", [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
map("n", "<leader>t", [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map("n", "<leader>f", [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
