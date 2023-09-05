local opts = {
  filetypes = {
    "svelte",
    "css",
  },
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("stylelint_lsp")

if server_available then
  requested_server:on_ready(function() requested_server:setup(opts) end)
end

-- require("lspconfig").stylelint_lsp.setup({
--   filetypes = {
--     "svelte",
--     "css",
--   },
-- })
