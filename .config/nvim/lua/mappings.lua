vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition()
end)
vim.keymap.set("n", "<C-W>d", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end)
vim.keymap.set("n", "<C-W><C-D>", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end)

vim.keymap.set("n", "gD", function()
  vim.lsp.buf.declaration()
end)
vim.keymap.set("n", "<C-W>D", function()
  vim.cmd("split")
  vim.lsp.buf.declaration()
end)

vim.keymap.set("n", "gr", function()
  vim.lsp.buf.references()
end)
vim.keymap.set("n", "<C-]>", function()
  vim.lsp.buf.implementation()
end)
vim.keymap.set("n", "<C-W>]", function()
  vim.cmd("split")
  vim.lsp.buf.implementation()
end)
vim.keymap.set("n", "<C-W><C-]>", function()
  vim.cmd("vsplit")
  vim.lsp.buf.implementation()
end)

vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end)
vim.keymap.set("n", "<leader>cA", "<cmd>TSLspFixCurrent<CR>")
vim.keymap.set("n", "<leader>ci", "<cmd>TSLspImportCurrent<CR>")
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<C-K>", function()
  vim.lsp.buf.signature_help()
end)

local float_opts = { scope = "line", header = "" }
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = float_opts })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = float_opts })
end)
vim.keymap.set("n", "<leader>cd", function()
  vim.diagnostic.open_float(float_opts)
end)
vim.keymap.set("n", "<leader>cD", function()
  vim.diagnostic.config({ virtual_text = false })
end)
vim.keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end)

vim.api.nvim_create_user_command("LspVirtualTextHide", function()
  vim.diagnostic.config({ virtual_text = false })
end, {
  nargs = 0,
  desc = "Hide LSP virtual text",
})

vim.api.nvim_create_user_command("SynAttr", "call SyntaxAttr()", {
  desc = "Show the highlight group under cursor",
})

local clear_search_hl = vim.api.nvim_create_augroup("ClearSearchHL", {})
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "/,?",
  command = "set hlsearch",
  group = clear_search_hl,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set nohlsearch",
  group = clear_search_hl,
})
vim.keymap.set("n", "n", "<cmd>set hlsearch<CR>n")
vim.keymap.set("n", "N", "<cmd>set hlsearch<CR>N")

vim.keymap.set("n", "<leader>y", function()
  vim.cmd("let @+=expand('%')")
  vim.notify(vim.fn.expand("%"), "info", { title = "Copied buffer path" })
end)
