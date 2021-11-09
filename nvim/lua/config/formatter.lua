local function prettier()
	return {
		exe = "./node_modules/.bin/prettier",
		args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
		stdin = true,
	}
end

local function gofmt()
	return {
		exe = "go fmt",
		args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
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
		svelte = { prettier },
		typescript = { prettier },
		typescriptreact = { prettier },
		markdown = { prettier },
		json = { prettier },
		html = { prettier },
		css = { prettier },
		lua = { stylua },
		go = { gofmt },
	},
})

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.json,*.go,*.js,*.ts,*.tsx,*.jsx,*.html,*.css,*.lua,*.md,*.svelte FormatWrite
augroup END
]],
	true
)
