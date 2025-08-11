return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        -- Recognize vim and other globals
        globals = { "vim" },
        disable = { "missing-fields" }, -- Disable noisy warnings for partial table definitions
      },
      workspace = {
        -- Tell lua_ls about Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- Disable third-party library prompts
      },
      telemetry = {
        enable = false, -- Don't send telemetry data
      },
    },
  },
}
