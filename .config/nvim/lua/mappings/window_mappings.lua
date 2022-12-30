-- Window wrapping mappings
vim.keymap.set("n", "[w", function()
  vim.opt.wrap = false
end)
vim.keymap.set("n", "]w", function()
  vim.opt.wrap = true
end)
vim.keymap.set("n", "<C-w>[w<C-w>p", "<CMD>windo set nowrap<CR>")
vim.keymap.set("n", "<C-w>]w<C-w>p", "<CMD>windo set wrap<CR>")

-- Maximise current window
vim.keymap.set("n", "<C-w><Space>", "<C-w>|<C-w>_")

-- Unimpaired quickfix list mappings
vim.keymap.set("n", "<leader>q", "<CMD>cw<CR><C-W>J")
vim.keymap.set("n", "[q", "<CMD>cprevious<CR>")
vim.keymap.set("n", "]q", "<CMD>cnext<CR>")
vim.keymap.set("n", "[Q", "<CMD>cfirst<CR>")
vim.keymap.set("n", "]Q", "<CMD>clast<CR>")

-- Unimpaired location list mappings
vim.keymap.set("n", "<leader>l", "<CMD>lw<CR><C-W>J")
vim.keymap.set("n", "[l", "<CMD>lprevious<CR>")
vim.keymap.set("n", "]l", "<CMD>lnext<CR>")
vim.keymap.set("n", "[L", "<CMD>lfirst<CR>")
vim.keymap.set("n", "]L", "<CMD>llast<CR>")

-- Unimpaired buffer mappings
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>")
vim.keymap.set("n", "]b", "<CMD>bnext<CR>")
vim.keymap.set("n", "[B", "<CMD>bfirst<CR>")
vim.keymap.set("n", "]B", "<CMD>blast<CR>")

-- Unimpaired tab mappings
vim.keymap.set("n", "[t", "gT")
vim.keymap.set("n", "]t", "gt")
vim.keymap.set("n", "[T", "<CMD>tabfirst<CR>")
vim.keymap.set("n", "]T", "<CMD>tablast<CR>")

-- Move to top level non-whitespace
vim.keymap.set("n", "[[", "<CMD>keeppatterns ?^\\S<CR>")
vim.keymap.set("n", "]]", "<CMD>keeppatterns /^\\S<CR>")

-- Tab navigation mappings
for i = 1, 8 do
  vim.keymap.set("n", "<C-w>" .. i, "<CMD>tabn " .. i .. "<CR>")
end
vim.keymap.set("n", "<C-w>0", "<CMD>tabfirst<CR>")
vim.keymap.set("n", "<C-w>9", "<CMD>tablast<CR>")

-- Open new vertical split mappings
vim.keymap.set("n", "<C-w><C-f>", "<C-w><C-v>gF")
vim.keymap.set("n", "<C-w><C-]>", "<C-w><C-v><C-]>", { remap = true })

-- Move tabs
vim.keymap.set("n", "g>", "<CMD>tabm +1<CR>")
vim.keymap.set("n", "g<", "<CMD>tabm -1<CR>")

-- Save temp session
vim.keymap.set("n", "<leader>]]", "<CMD>mks! ~/sess/temp_session.vim<CR>")
vim.keymap.set("n", "<leader>[[", "<CMD>source ~/sess/temp_session.vim<CR>")

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
end)
