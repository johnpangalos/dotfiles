local function prettier()
	return {
		exe = "prettier_d_slim",
		args = { "--stdin", "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
		stdin = true,
	}
end

local function stylua()
	return { exe = "stylua", args = { "--search-parent-directories", "-" }, stdin = true }
end

require("formatter").setup({
	filetype = {
		javascriptreact = { prettier },
		javascript = { prettier },
		typescript = { prettier },
		typescriptreact = { prettier },
		markdown = { prettier },
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
  autocmd BufWritePost *.js,*.ts,*.tsx,*.jsx,*.html,*.css,*.lua,*.md FormatWrite
augroup END
]],
	true
)
