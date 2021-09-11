local function prettier()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
		stdin = true,
	}
end

local function stylua()
	return { exe = "stylua", args = { "--search-parent-directories", "-" }, stdin = true }
end

require("formatter").setup({
	filetype = {
		javascript = { prettier },
		json = { prettier },
		html = { prettier },
		css = { prettier },
		lua = { stylua },
	},
})

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx,*.jsx,*.html,*.css,*.lua FormatWrite
augroup END
]],
	true
)
