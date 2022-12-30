local opts = {
  filetypes = {
    "html",
    "css",
    "javascriptreact",
    "typescriptreact",
    "svelte",
    "handlebars",
  },
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("emmet_ls")

if server_available then
  requested_server:on_ready(function() requested_server:setup(opts) end)
end
