return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    keys = {
      {
        "<leader>j",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = function()
      ---@class ConformOpts
      local opts = {
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
        formatters_by_ft = {
          sh = { "shfmt", "trim_newlines", "trim_whitespace" },
          lua = { "stylua", "trim_newlines", "trim_whitespace" },
          css = { "prettier", "trim_whitespace" },
          javascript = { "prettier", "trim_whitespace" },
          javascriptreact = { "prettier", "trim_whitespace" },
          typescript = { "prettier", "trim_newlines", "trim_whitespace" },
          html = { "prettier", "trim_newlines", "trim_whitespace" },
          typescriptreact = { "prettier", "trim_newlines", "trim_whitespace" },
          go = { "gofmt", "trim_newlines", "trim_whitespace" },
          markdown = { "prettier", "trim_newlines", "trim_whitespace" },
        },
      }
      return opts
    end,
  },
}
