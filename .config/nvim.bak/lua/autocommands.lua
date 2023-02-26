-- Disable automatic comment insertion
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FormatOptionsAutogroup", {}),
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- Filetype handling
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("FileTypeAutogroup", {}),
  pattern = "*.js.tftmpl",
  command = "setlocal filetype=javascript",
})

-- Skeletons
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("SkeletonsAutogroup", {}),
  pattern = "*.test.tsx",
  command = "0r ~/.config/nvim/skeletons/jest.test.tsx",
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursorPosAutogroup", {}),
  pattern = "*",
  command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif ]],
})

-- Cursorline
local cursorline_autogroup = vim.api.nvim_create_augroup("CursorlineAutogroup", {})
vim.api.nvim_create_autocmd({ "FocusLost", "InsertEnter", "WinLeave", "BufWinLeave", "CmdwinLeave" }, {
  group = cursorline_autogroup,
  pattern = "*",
  callback = function()
    if vim.o.ft ~= "NvimTree" then
      vim.o.cursorline = false
    end
  end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave", "WinEnter", "BufWinEnter", "CmdwinEnter" }, {
  group = cursorline_autogroup,
  pattern = "*",
  callback = function() vim.o.cursorline = true end,
})

-- Relative Number toggle
vim.g.numbertoggle = false
local number_toggle_autogroup = vim.api.nvim_create_augroup("NumberToggleAutogroup", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = number_toggle_autogroup,
  pattern = "*",
  callback = function()
    if vim.o.number and not vim.g.numbertoggle and vim.fn.mode() ~= "i" then
      vim.o.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = number_toggle_autogroup,
  pattern = "*",
  callback = function()
    if vim.o.number and not vim.g.numbertoggle then
      vim.o.relativenumber = false
    end
  end,
})
vim.keymap.set("n", "<C-Space>", function()
  vim.g.numbertoggle = not vim.g.numbertoggle
  vim.o.relativenumber = not vim.o.relativenumber
end)

-- Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlightAutogroup", {}),
  pattern = "*",
  callback = function() vim.highlight.on_yank({ higroup = "Search", timeout = 200 }) end,
})
