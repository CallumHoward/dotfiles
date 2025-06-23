-- Window wrapping mappings
vim.keymap.set("n", "[w", function()
  vim.opt.wrap = false
end, { desc = "Disable window wrapping" })
vim.keymap.set("n", "]w", function()
  vim.opt.wrap = true
end, { desc = "Enable window wrapping" })
vim.keymap.set("n", "<C-w>[W", "<CMD>windo set nowrap<CR>", { desc = "Disable wrapping in all windows" })
vim.keymap.set("n", "<C-w>]W", "<CMD>windo set wrap<CR>", { desc = "Enable wrapping in all windows" })

-- Maximise current window
vim.keymap.set("n", "<C-w><Space>", "<C-w>|<C-w>_", { desc = "Maximize current window" })

-- Unimpaired quickfix list mappings
vim.keymap.set("n", "[q", "<CMD>cprevious<CR>", { desc = "Go to previous quickfix" })
vim.keymap.set("n", "]q", "<CMD>cnext<CR>", { desc = "Go to next quickfix" })
vim.keymap.set("n", "[Q", "<CMD>cfirst<CR>", { desc = "Go to first quickfix" })
vim.keymap.set("n", "]Q", "<CMD>clast<CR>", { desc = "Go to last quickfix" })

-- Unimpaired location list mappings
vim.keymap.set("n", "[l", "<CMD>lprevious<CR>", { desc = "Go to previous location" })
vim.keymap.set("n", "]l", "<CMD>lnext<CR>", { desc = "Go to next location" })
vim.keymap.set("n", "[L", "<CMD>lfirst<CR>", { desc = "Go to first location" })
vim.keymap.set("n", "]L", "<CMD>llast<CR>", { desc = "Go to last location" })

-- Unimpaired buffer mappings
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "[B", "<CMD>bfirst<CR>", { desc = "Go to first buffer" })
vim.keymap.set("n", "]B", "<CMD>blast<CR>", { desc = "Go to last buffer" })

-- Unimpaired tab mappings
vim.keymap.set("n", "[t", "gT", { desc = "Go to previous tab" })
vim.keymap.set("n", "]t", "gt", { desc = "Go to next tab" })
vim.keymap.set("n", "[T", "<CMD>tabfirst<CR>", { desc = "Go to first tab" })
vim.keymap.set("n", "]T", "<CMD>tablast<CR>", { desc = "Go to last tab" })

-- Move to top level non-whitespace
vim.keymap.set("n", "[[", "<CMD>keeppatterns ?^\\S<CR>", { desc = "Move to previous non-whitespace" })
vim.keymap.set("n", "]]", "<CMD>keeppatterns /^\\S<CR>", { desc = "Move to next non-whitespace" })

-- Tab navigation mappings
for i = 1, 8 do
  vim.keymap.set("n", "<C-w>" .. i, "<CMD>tabn " .. i .. "<CR>", { desc = "Go to tab " .. i })
end
vim.keymap.set("n", "<C-w>0", "<CMD>tabfirst<CR>", { desc = "Go to first tab" })
vim.keymap.set("n", "<C-w>9", "<CMD>tablast<CR>", { desc = "Go to last tab" })

-- Open new vertical split mappings
vim.keymap.set("n", "<C-w><C-f>", "<C-w><C-v>gF", { desc = "Open new vertical split" })
vim.keymap.set("n", "<C-w><C-]>", "<C-w><C-v><C-]>", { remap = true, desc = "Open new vertical split with tag jump" })

-- Move tabs
vim.keymap.set("n", "g>", "<CMD>tabm +1<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "g<", "<CMD>tabm -1<CR>", { desc = "Move tab left" })

-- Close tab
vim.keymap.set("n", "<leader><M-w>", "<CMD>tabclose<CR>", { desc = "Close tab" })

-- Save temp session
-- vim.keymap.set("n", "<leader>]]", "<CMD>mks! ~/sess/temp_session.vim<CR>")
-- vim.keymap.set("n", "<leader>[[", "<CMD>source ~/sess/temp_session.vim<CR>")

-- Delete buffer
vim.keymap.set("n", "<M-w>", "<CMD>bd<CR>")

-- Terminal window mappings
vim.keymap.set("t", "<C-w><C-w>", "<C-\\><C-n><C-w><C-w>")
vim.keymap.set("t", "<C-w><C-h>", "<C-\\><C-n><C-w><C-h>")
vim.keymap.set("t", "<C-w><C-j>", "<C-\\><C-n><C-w><C-j>")
vim.keymap.set("t", "<C-w><C-k>", "<C-\\><C-n><C-w><C-k>")
vim.keymap.set("t", "<C-w><C-l>", "<C-\\><C-n><C-w><C-l>")

-- Toggle diff
vim.keymap.set("n", "<leader>d", function()
  if vim.wo.diff then
    vim.cmd("windo diffoff")
  else
    vim.cmd("windo diffthis")
  end
  vim.cmd("wincmd w")
end, { desc = "Toggle Diff" })
