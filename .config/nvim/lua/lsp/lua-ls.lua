local opts = {
  settings = {
    Lua = {
      runtime = {
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        maxPreload = 100000,
        preloadFileSize = 1000,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("sumneko_lua")

if server_available then
  requested_server:on_ready(function() requested_server:setup(opts) end)
end
