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

-- Documentation
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help)

-- Diagnostics
local float_opts = { scope = "line", header = "" }
local show_diagnostics_virtual_text = true
local toggle_diagnostic_virtual_text = function()
  show_diagnostics_virtual_text = not show_diagnostics_virtual_text
  vim.diagnostic.config({ virtual_text = show_diagnostics_virtual_text })
end

local show_diagnostics_virtual_text_autogroup = vim.api.nvim_create_augroup("DiagnosticsVirtualTextAutogroup", {})
vim.api.nvim_create_autocmd("CursorMoved", {
  group = show_diagnostics_virtual_text_autogroup,
  pattern = "*",
  callback = function() vim.diagnostic.config({ virtual_text = show_diagnostics_virtual_text }) end,
})

vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ float = false }) end)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ float = false }) end)
vim.keymap.set("n", "<leader>cd", function()
  vim.diagnostic.config({ virtual_text = false })
  vim.diagnostic.open_float(float_opts)
end)
vim.keymap.set("n", "<leader>cD", toggle_diagnostic_virtual_text)
