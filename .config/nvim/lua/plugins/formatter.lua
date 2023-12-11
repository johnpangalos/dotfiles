vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>j",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        sh = { "shfmt", "trim_newlines", "trim_whitespace" },
        lua = { "stylua", "trim_newlines", "trim_whitespace" },
        javascript = { "prettier", "trim_whitespace" },
        javascriptreact = { "prettier", "trim_whitespace" },
        typescript = { "prettier", "trim_newlines", "trim_whitespace" },
        html = { "prettier", "trim_newlines", "trim_whitespace" },
        typescriptreact = { "prettier", "trim_newlines", "trim_whitespace" },
        go = { "gofmt", "trim_newlines", "trim_whitespace" },
        markdown = { "prettier", "trim_newlines", "trim_whitespace" },
      },
      -- format_on_save = function(bufnr)
      --   local ignore_filetypes = { "markdown" }
      --   if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      --     return
      --   end
      --   return { timeout_ms = 500, lsp_fallback = true }
      -- end,
    },
  },
}
