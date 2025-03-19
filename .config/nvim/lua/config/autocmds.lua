-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable automatic comment insertion
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FormatOptionsAutogroup", {}),
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- Filetype handling
local filetype_autogroup = vim.api.nvim_create_augroup("FileTypeAutogroup", {})
vim.api.nvim_create_autocmd("BufEnter", {
  group = filetype_autogroup,
  pattern = "*.js.tftmpl",
  command = "setlocal filetype=javascript",
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = filetype_autogroup,
  pattern = "*.postcss",
  command = "setlocal filetype=css.postcss",
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = filetype_autogroup,
  pattern = "*.mdx",
  command = "setlocal filetype=markdown.mdx",
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_autogroup,
  pattern = "qf",
  command = "setlocal nowrap",
})

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_autogroup,
  pattern = "lazy",
  command = "setl signcolumn=no",
})

-- Skeletons
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("SkeletonsAutogroup", {}),
  pattern = "*.test.tsx",
  command = "0r ~/.config/nvim/skeletons/jest.test.tsx",
})

-- Cursorline
local cursorline_autogroup = vim.api.nvim_create_augroup("CursorlineAutogroup", {})
vim.api.nvim_create_autocmd({ "FocusLost", "InsertEnter", "WinLeave", "BufWinLeave", "CmdwinLeave" }, {
  group = cursorline_autogroup,
  pattern = "*",
  callback = function()
    if vim.o.ft ~= "neo-tree" then
      vim.o.cursorline = false
    end
  end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave", "WinEnter", "BufWinEnter", "CmdwinEnter" }, {
  group = cursorline_autogroup,
  pattern = "*",
  callback = function()
    if vim.o.buftype ~= "nofile" and vim.o.buftype ~= "terminal" then
      vim.o.cursorline = true
    end
  end,
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
vim.keymap.set("n", "<leader><C-Space>", function()
  vim.g.numbertoggle = not vim.g.numbertoggle
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative line numbers" })

-- Resize splits if window got resized
vim.api.nvim_del_augroup_by_name("lazyvim_resize_splits")
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("ResizeSplits", {}),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Name tmux windows
function SetTmuxTitle()
  local title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  if string.find(title, "man") then
    -- Do nothing
  elseif title ~= "" then
    vim.fn.system('tmux rename-window " ' .. title .. '"')
  else
    vim.fn.system('tmux rename-window " nvim"')
  end
end

if vim.fn.exists("$TMUX") then
  local tmux_title_autogroup = vim.api.nvim_create_augroup("TmuxTitleAutogroup", {})
  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "FocusGained", "CmdlineLeave" }, {
    group = tmux_title_autogroup,
    pattern = "*",
    callback = SetTmuxTitle,
  })
  vim.api.nvim_create_autocmd({ "WinEnter" }, {
    group = tmux_title_autogroup,
    pattern = "*",
    callback = function()
      vim.g.tmux_window_target = vim.fn.system("tmux display-message -p '#S:#I'")
    end,
  })
end
