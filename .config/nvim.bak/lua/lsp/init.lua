local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  "cssls",
  "dartls",
  "diagnosticls",
  "dockerls",
  -- "ember",
  "emmet_ls",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "pyright",
  "sumneko_lua",
  "sourcekit",
  "svelte",
  -- "stylelint_lsp",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    else
      server:on_ready(function()
        server:setup({
          capabilities = capabilities,
        })
      end)
    end
  end
end

require("lspconfig").sourcekit.setup({
  capabilities = capabilities,
})

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.api.nvim_exec(
  [[
    augroup VirtualTextToggleAutogroup
      autocmd!
      autocmd InsertEnter * lua vim.diagnostic.config({ virtual_text = false })
      autocmd InsertEnter * hi link GitSignsCurrentLineBlame EndOfBuffer
      autocmd InsertLeave * lua vim.diagnostic.config({ virtual_text = true })
      autocmd InsertLeave * hi link GitSignsCurrentLineBlame Comment
  augroup END
  ]],
  true
)

require("vim.lsp.protocol").CompletionItemKind = {
  "   (Text)",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)",
}
