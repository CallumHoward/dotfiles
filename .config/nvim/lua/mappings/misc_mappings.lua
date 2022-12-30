-- Copy buffer relative filepath
vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  vim.notify(vim.fn.expand("%"), "info", { title = "Copied buffer path" })
end)

-- Swap mark keys
vim.keymap.set("n", "'", "`")
vim.keymap.set("n", "`", "'")

-- Select last pasted
vim.keymap.set("n", "gV", "`[v`]")

-- Markdown link shortcut
vim.keymap.set("n", "<C-K>", "ysiw]'>a()<Left>", { remap = true })
vim.keymap.set("x", "<C-K>", "S]'>a()<Left>", { remap = true })

-- Go to alternate file
vim.keymap.set("n", "<leader>e", "<CMD>e %<.")
vim.keymap.set("n", "<leader>E", "<CMD>vs %<.")

-- Search SCM markers
vim.keymap.set("n", "g/", "/^[<=>]\\{7}<CR>")

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
vim.keymap.set("n", "z]", "<CMD><C-u>silent! normal! zc<CR>zjzozz")
vim.keymap.set("n", "z[", "<CMD><C-u>silent! normal! zc<CR>zkzo[zzz")
vim.keymap.set("n", "zV", "<CMD><C-u>silent! normal! zM<CR>zv")
vim.keymap.set("n", "<Space>", "za")

-- Resync syntax highlighting
vim.keymap.set("n", "<C-l>", "<C-l><CMD>syntax sync fromstart<CR>")

-- Quickly set foldlevel
for i = 1, 5 do
  vim.keymap.set("n", "<leader>" .. i, "<CMD>set foldnestmax=" .. i .. "<CR>")
end

-- Readline-like delete to end of line
vim.keymap.set("i", "<C-k>", "<C-o>D")

-- Remove trailing whitespace
vim.keymap.set("n", "<leader><Space>", "<CMD>keeppatterns %s/\\s\\+$//e<CR><C-o>")
vim.keymap.set("x", "<leader><Space>", "<CMD>keeppatterns s/\\s\\+$//e<CR><C-o>")

-- Global subsitution on last used search pattern
vim.keymap.set("n", "<leader>s", "<CMD>set icm=split<CR>:%s///g<Left><Left>")
vim.keymap.set("x", "<leader>s", "<CMD>set icm=nosplit<CR>:s///g<Left><Left>")

-- Global mappings
vim.keymap.set({ "n", "x" }, "<leader>gn", ":g//norm ")
vim.keymap.set({ "n", "x" }, "<leader>gd", ":g//norm ")
vim.keymap.set({ "n", "x" }, "<leader>gD", ":g//norm ")
