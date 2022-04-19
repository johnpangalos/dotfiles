local function prettier()
	return {
		exe = "./node_modules/.bin/prettier",
		args = { "--plugin-search-dir=.", "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
		stdin = true,
	}
end

local function gofmt()
	return {
		exe = "gofmt",
		-- args = { "-w" },
		stdin = true,
	}
end

local function stylua()
	return { exe = "stylua", args = { "--search-parent-directories", "-" }, stdin = true }
end

local function rustfmt()
	return {
		exe = "rustfmt",
		args = { "--emit=stdout --edition 2018" },
		stdin = true,
	}
end

local function terraform()
	return {
		exe = "terraform",
		args = { "fmt", "-" },
		stdin = true,
	}
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
		yml = { prettier },
		html = { prettier },
		css = { prettier },
		lua = { stylua },
		go = { gofmt },
		rust = { rustfmt },
		terraform = { terraform },
	},
})

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.rs,*.json,*.go,*.js,*.ts,*.tsx,*.jsx,*.html,*.css,*.lua,*.md,*.svelte,*.tf FormatWrite
augroup END
]],
	true
)
