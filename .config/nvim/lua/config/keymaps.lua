-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("s", "kj", "<ESC>")

require("config.mappings")

local Util = require("lazyvim.util")
local Snacks = require("snacks")

local map = vim.keymap.set

-- Move Lines TODO support count
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
if Util.has("bufferline.nvim") then
  map("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- stylua: ignore start

-- Toggle options
map("n", "<leader>uf", require("lazyvim.util.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Snacks.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Snacks.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ur", function()
  vim.g.numbertoggle = not vim.g.numbertoggle
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative line numbers" })
map("n", "<leader>uN", function()
  vim.g.numbertoggle = not vim.g.numbertoggle
  vim.o.relativenumber = not vim.o.relativenumber
  vim.o.number = not vim.o.number
end, { desc = "Toggle line numbers" })
map("n", "<leader>ud", function() Snacks.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- stylua: ignore end

function ToggleWholeWordSearch()
  local current_search = vim.fn.getreg("/")

  if current_search:match("^\\<.*\\>$") then
    current_search = current_search:gsub("\\<", ""):gsub("\\>", "")
  else
    current_search = "\\<" .. current_search .. "\\>"
  end

  vim.fn.setreg("/", current_search)
end

map("n", "<leader>w", ToggleWholeWordSearch)

-- Highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- Kitty mapping
map("n", "<leader>ty", '"+yy')
map("v", "<leader>ty", '"+y')
