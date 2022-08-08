-- make sure to only run this once!
local opts = {
  on_attach = function(client, bufnr)
    -- Enable winbar breadcrumbs navigator
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)

    -- Winbar breadcrumps navigator config
    vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("tsserver")

if server_available then
  requested_server:on_ready(function()
    requested_server:setup(opts)
  end)
end
