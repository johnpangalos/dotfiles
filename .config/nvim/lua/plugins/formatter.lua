return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      -- local null_ls_h = require("null-ls.helpers")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.gofmt,
          -- null_ls.builtins.formatting.prettier.with({
          --   command = "pnpm",
          --   args = null_ls_h.range_formatting_args_factory({
          --     "prettier",
          --     "--stdin-filepath",
          --     "$FILENAME",
          --   }, "--range-start", "--range-end", { row_offset = -3, col_offset = -1 }),
          --   extra_args = {
          --     "--plugin-search-dir=.",
          --   },
          --   extra_filetypes = {
          --     "svelte",
          --     "astro",
          --   },
          -- }),
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
    end,
  },
  {
    "prettier/vim-prettier",
    config = function()
      vim.cmd(
        "autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync"
      )
    end,
  },
}
