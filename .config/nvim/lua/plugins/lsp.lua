return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Configure global LSP settings
      vim.lsp.config('*', {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true
              }
            }
          }
        },
        root_markers = { '.git', '.hg' }
      })

      -- Setup LSP attach autocmd for keymaps and features
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf

          -- Enable completion if supported
          if client and client.supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
          end

          -- Enable formatting on save if supported
          if client and client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('LspFormatting', { clear = false }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000 })
              end
            })
          end

          -- Buffer-local keymaps
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('n', '<leader>cd', vim.lsp.buf.rename, 'Rename symbol')
          map('n', '<leader>e', vim.diagnostic.open_float, 'Open diagnostic float')
          map('n', '<leader>q', vim.diagnostic.setloclist, 'Set diagnostic loclist')
          map('i', '<C-Space>', vim.lsp.completion.get, 'Trigger completion')
        end
      })

      -- Enable LSP for configured servers
      vim.lsp.enable({ 'lua_ls', 'vtsls' })
    end
  }
}
