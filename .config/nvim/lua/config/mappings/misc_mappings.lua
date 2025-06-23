-- Copy buffer relative filepath
vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  vim.notify(vim.fn.expand("%"), "info", { title = "Copied buffer path" })
end, { desc = "Copy relative path" })

-- Swap mark keys
vim.keymap.set("n", "'", "`")
vim.keymap.set("n", "`", "'")

-- Select last pasted
vim.keymap.set("n", "gV", "`[v`]", { desc = "Select last pasted" })

-- Markdown link shortcut
vim.keymap.set("n", "<C-K>", "ysiw]f]a()<Left>", { remap = true })
vim.keymap.set("x", "<C-K>", "S]f]a()<Left>", { remap = true })

-- Go to alternate file
vim.keymap.set("n", "<leader>e", ":e %<.", { desc = "Edit alternate file" })
vim.keymap.set("n", "<leader>E", ":vs %<.", { desc = "Edit alternate file in vertical split" })

-- Search SCM markers
vim.keymap.set("n", "g/", "/^[<=>]\\{7}<CR>", { desc = "Search SCM markers" })

-- Dot command works on ranges
vim.keymap.set("x", ".", "<CMD>normal .<CR>")

-- Wrapped line movement mappings (adds larger jumps to jumplist)
local jump = function(key, threshold)
  return vim.v.count > threshold and "m'" .. vim.v.count .. key or "g" .. key
end
for _, v in ipairs({ "j", "k" }) do
  vim.keymap.set({ "n", "x" }, v, function()
    return jump(v, 5)
  end, { expr = true })
end

-- Incremental commandline history search
vim.keymap.set("c", "<C-n>", function()
  return vim.fn.wildmenumode() and "\\<C-n>" or "\\<down>"
end, { expr = true })
vim.keymap.set("c", "<C-p>", function()
  return vim.fn.wildmenumode() and "\\<C-p>" or "\\<up>"
end, { expr = true })

-- Accordion expand traversal of folds
vim.keymap.set("n", "z]", "<CMD>silent! normal! zc<CR>zjzozz")
vim.keymap.set("n", "z[", "<CMD>silent! normal! zc<CR>zkzo[zzz")
vim.keymap.set("n", "zV", "<CMD>silent! normal! zM<CR>zv")
vim.keymap.set("n", "<Space>", "za")
-- vim.keymap.set("n", "<M-]>", "zj")
-- vim.keymap.set("n", "<M-[>", "zk")

-- Resync syntax highlighting
vim.keymap.set("n", "<C-l>", "<C-l><CMD>syntax sync fromstart<CR>")

-- Quickly set foldlevel
for i = 1, 5 do
  vim.keymap.set("n", "<leader>" .. i, "<CMD>setl foldnestmax=" .. i .. "<CR>", { desc = "which_key_ignore" })
end

-- Readline-like delete to end of line
vim.keymap.set("i", "<C-k>", "<C-o>D")

-- Remove trailing whitespace
vim.keymap.set(
  "n",
  "<leader><Space>",
  "<CMD>keeppatterns %s/\\s\\+$//e<CR><C-o>",
  { desc = "Remove trailing whitespace" }
)
vim.keymap.set(
  "x",
  "<leader><Space>",
  "<CMD>keeppatterns s/\\s\\+$//e<CR><C-o>",
  { desc = "Remove trailing whitespace" }
)

-- Global subsitution on last used search pattern
vim.keymap.set("n", "<leader>s", "<CMD>set icm=split<CR>:%s///g<Left><Left>", { desc = "Substitute Searched" })
vim.keymap.set("x", "<leader>s", "<CMD>set icm=nosplit<CR>:s///g<Left><Left>", { desc = "Substitute Searched" })

-- Global mappings
vim.keymap.set({ "n", "x" }, "<leader>gn", ":g//norm ", { desc = "Normal on Searched Lines" })
vim.keymap.set({ "n", "x" }, "<leader>gd", ":g//d<CR>", { desc = "Delete Searched Lines" })
vim.keymap.set({ "n", "x" }, "<leader>gD", ":v//d<CR>", { desc = "Keep Searched Lines" })

-- Toggle treesitter highlight
vim.keymap.set("n", "<leader>uT", function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
  else
    vim.treesitter.start()
  end
end, { desc = "Toggle Treesitter Highlight" })
