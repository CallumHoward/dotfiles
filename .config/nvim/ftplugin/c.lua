vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.commentstring = "//%s"
  end,
})

vim.opt_local.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.env.CFLAGS = "-Wall -Wextra -pedantic -Wno-unused-parameter -std=c99 -g"

vim.opt.path:append("/usr/local/opt/llvm/include/c++/v1")

-- jump to #includes and add a new include prepolulated with word under cursor
vim.keymap.set("n", "<leader>i", 'm`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include <<C-R>1><Esc>hvi><C-G>', { buffer = true })
vim.keymap.set("n", "<leader>I", 'm`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include "<C-R>1.h"<Esc>hvi"<C-G>', { buffer = true })

-- convert c-style prototypes to functions
vim.keymap.set("n", "<leader>;", ":keeppatterns %s/;$/ {\\r\\r}\\r<CR>:noh<CR><C-O>", { buffer = true })
vim.keymap.set("x", "<leader>;", ":s/;$/ {\\r\\r}\\r<CR>:noh<CR><C-O>", { buffer = true })

-- add function prototype for function under cursor
vim.keymap.set("n", "<leader>p", 'yy:keeppatterns ?^#include\\><CR>jp:keeppatterns s/\\s*{$/;<CR>:silent! keeppatterns s/(\\zs\\ze);/void<CR>:noh<CR><C-O>', { buffer = true, silent = true })
vim.keymap.set("x", "<leader>p", 'y:keeppatterns ?^#include\\><CR>jp:keeppatterns s/\\s*{$/;<CR>:silent! keeppatterns s/(\\zs\\ze);/void<CR>:noh<CR><C-O>', { buffer = true, silent = true })