local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.prettier.with({
      extra_args = {
        "--plugin-search-dir=.",
      },
      extra_filetypes = {
        "svelte",
        "astro",
      },
    }),
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.zigfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})
