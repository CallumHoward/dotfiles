-- LspInstall setup
local function setup_servers()
  require("lspinstall").setup()
  local servers = require("lspinstall").installed_servers()
  for _, server in pairs(servers) do
    require("lspconfig")[server].setup({})
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Lsp configuration
DATA_PATH = vim.fn.stdpath("data")

local signs = {
  { name = "LspDiagnosticsSignError", text = "" },
  { name = "LspDiagnosticsSignWarning", text = "" },
  { name = "LspDiagnosticsSignHint", text = "" },
  { name = "LspDiagnosticsSignInformation", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> <C-W>d :sp<CR><cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> <C-W><C-D> :vs<CR><cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> <C-W>D :sp<CR><cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>:cope<CR><C-W>J")
vim.cmd("nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <C-W>] :sp<CR><cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <C-W><C-]> :vs<CR><cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>")
vim.cmd("nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>")
vim.cmd("nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.cmd("nnoremap <silent> [C <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
vim.cmd("nnoremap <silent> ]C <cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
vim.cmd("nnoremap <silent> cr <cmd>lua vim.lsp.buf.rename()<CR>")
vim.cmd("nnoremap <silent> cd <cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })<CR>")
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')
vim.cmd('cabbrev T <c-r>=(getcmdtype()==":" && getcmdpos()==1 ? "Telescope" : "T")<CR>')

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
