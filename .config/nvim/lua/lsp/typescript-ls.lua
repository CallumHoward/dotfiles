-- Make sure to only run this file once!

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.uri, "%.d.ts") == nil
end

local opts = {
  on_attach = function(client, bufnr)
    -- Enable winbar breadcrumbs navigator
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)

    -- Winbar breadcrumps navigator config
    vim.opt_local.winbar = " %{%v:lua.require('nvim-navic').get_location()%}"
  end,

  handlers = {
    -- Filter out results in d.ts files (usually inside node_modules)
    ["textDocument/definition"] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
      end

      vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
    end,
  },
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("tsserver")

if server_available then
  requested_server:on_ready(function()
    requested_server:setup(opts)
  end)
end
