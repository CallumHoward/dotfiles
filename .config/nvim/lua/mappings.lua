-- Jump to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<C-W>d", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end)
vim.keymap.set("n", "<C-W><C-D>", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end)

-- Jump to declaration
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<C-W>D", function()
  vim.cmd("split")
  vim.lsp.buf.declaration()
end)

-- Jump to implementation
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<C-]>", vim.lsp.buf.implementation)
vim.keymap.set("n", "<C-W>]", function()
  vim.cmd("split")
  vim.lsp.buf.implementation()
end)
vim.keymap.set("n", "<C-W><C-]>", function()
  vim.cmd("vsplit")
  vim.lsp.buf.implementation()
end)

-- Refactor and fix
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cA", "<cmd>TSLspFixCurrent<CR>")
vim.keymap.set("n", "<leader>ci", "<cmd>TSLspImportCurrent<CR>")

-- Documentation
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help)

-- Diagnostics
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

-- Search highlight behaviour
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

-- Copy buffer relative filepath
vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  vim.notify(vim.fn.expand("%"), "info", { title = "Copied buffer path" })
end)

vim.keymap.set("n", "[w", function()
  vim.opt.wrap = false
end)

vim.keymap.set("n", "]w", function()
  vim.opt.wrap = true
end)

vim.keymap.set("n", "<C-w>[w", "<Cmd>windo set nowrap<CR>")
vim.keymap.set("n", "<C-w>]w", "<Cmd>windo set wrap<CR>")
vim.keymap.set("n", "<C-w><Space>", "<C-w>|<C-w>_")
