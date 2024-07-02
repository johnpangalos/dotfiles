local LazyUtil = require("lazy.core.util")

local cmd = vim.cmd
local o_s = vim.o
local map_key = vim.api.nvim_set_keymap

local function opt(o, v, scopes)
  scopes = scopes or { o_s }
  for _, s in ipairs(scopes) do
    s[o] = v
  end
end

local function autocmd(group, cmds, clear)
  clear = clear == nil and false or clear
  if type(cmds) == "string" then
    cmds = { cmds }
  end
  cmd("augroup " .. group)
  if clear then
    cmd([[au!]])
  end
  for _, c in ipairs(cmds) do
    cmd("autocmd " .. c)
  end
  cmd([[augroup END]])
end

local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    map_key(mode, lhs, rhs, opts)
  end
end

local function execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  if opts.open then
    require("trouble").open({
      mode = "lsp_command",
      params = params,
    })
  else
    return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
  end
end

local action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})
---
---@param callback fun(client:vim.lsp.Client, buffer)
---@param name? string
local function on_attach(callback, name)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return callback(client, buffer)
      end
    end,
  })
end

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
local function get_pkg_path(pkg, path, opts)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  return ret
end

local function get_clients(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

local function format(opts)
  opts = vim.tbl_deep_extend(
    "force",
    {},
    opts or {},
    require("nvim-lspconfig").format or {},
    require("conform.nvim").format or {}
  )
  local ok, conform = pcall(require, "conform")
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

local function formatter(opts)
  opts = opts or {}
  local filter = opts.filter or {}
  filter = type(filter) == "string" and { name = filter } or filter
  local ret = {
    name = "LSP",
    primary = true,
    priority = 1,
    format = function(buf)
      format(LazyUtil.merge({}, filter, { bufnr = buf }))
    end,
    sources = function(buf)
      local clients = get_clients(LazyUtil.merge({}, filter, { bufnr = buf }))
      ---@param client vim.lsp.Client
      local ret = vim.tbl_filter(function(client)
        return client.supports_method("textDocument/formatting")
          or client.supports_method("textDocument/rangeFormatting")
      end, clients)
      ---@param client vim.lsp.Client
      return vim.tbl_map(function(client)
        return client.name
      end, ret)
    end,
  }
  return LazyUtil.merge(ret, opts)
end

return {
  opt = opt,
  autocmd = autocmd,
  map = map,
  execute = execute,
  action = action,
  on_attach = on_attach,
  get_pkg_path = get_pkg_path,
  get_clients = get_clients,
  formatter = formatter,
}
