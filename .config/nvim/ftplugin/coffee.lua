
local filetype_autogroup = vim.api.nvim_create_augroup("FileTypeAutogroup", {})
vim.api.nvim_create_autocmd("BufEnter", {
  group = filetype_autogroup,
  pattern = "*",
  command = "setlocal formatexpr=",
})
