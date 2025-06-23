pcall(vim.keymap.del, "n", "K")
pcall(vim.keymap.del, "n", "<C-]>")
vim.keymap.set("n", "gd", "<C-]>", { buffer = true })