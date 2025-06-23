vim.opt_local.spell = false
pcall(vim.keymap.del, "n", "<C-]>")
vim.keymap.set("n", "gd", "<C-]>", { buffer = true })