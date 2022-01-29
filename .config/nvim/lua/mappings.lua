local opts = { silent = true, noremap = true }

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-W>d", "<cmd>sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-W><C-D>", "<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-W>D", "<cmd>sp<CR><cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>:cope<CR><C-W>J", opts)
vim.api.nvim_set_keymap("n", "<C-]>", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-W>]", "<cmd>sp<CR><cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-W><C-]>", "<cmd>vs<CR><cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>cA", "<cmd>TSLspFixCurrent<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>TSLspImportCurrent<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "cd", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", header = "" })<CR>', opts)
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.cmd("command! SynAttr :call SyntaxAttr()")

vim.api.nvim_exec(
  [[
    augroup ClearSearchHL
      autocmd!
      autocmd CmdlineEnter /,\? set hlsearch
      autocmd InsertEnter * set nohlsearch
    augroup END
  ]],
  true
)
vim.api.nvim_set_keymap("n", "n", "<cmd>set hlsearch<CR>n", opts)
vim.api.nvim_set_keymap("n", "N", "<cmd>set hlsearch<CR>N", opts)

vim.api.nvim_set_keymap(
  "n",
  "<leader>y",
  "<cmd>let @+=expand('%')<CR>:lua vim.notify(vim.fn.expand('%'), 'info', { title = 'Copied buffer path' })<CR>",
  opts
)
