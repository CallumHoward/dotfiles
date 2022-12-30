-- Prevent jump after searching word under cursor with # and *
local hl_cword = function(exclusive, reverse)
  local save_cursor = vim.fn.getcurpos()
  local cword = vim.fn.expand("<cword>")
  if exclusive then
    vim.fn.setreg("/", "\\<" .. cword .. "\\>")
  else
    vim.fn.setreg("/", cword)
  end
  vim.opt.hlsearch = true
  if reverse then
    vim.cmd("normal! w?<CR>")
  end
  vim.cmd("%s///gn") -- Echo match number
  vim.fn.setpos(".", save_cursor)
end

vim.keymap.set("n", "#", function() hl_cword(true, true) end)
vim.keymap.set("n", "g#", function() hl_cword(true, true) end)
vim.keymap.set("n", "*", function() hl_cword(false, false) end)
vim.keymap.set("n", "g*", function() hl_cword(false, false) end)

-- Make * and # work on visual mode too
local v_set_search = function(cmdtype)
  local temp = vim.fn.getreg("o")
  vim.cmd([[ normal! "oy ]])
  local selection = vim.fn.getreg("o")
  local escaped = vim.fn.escape(selection, cmdtype .. "\\")
  local multiline_pattern = vim.fn.substitute(escaped, "\\n", "\\\\n", "g")
  vim.fn.setreg("/", "\\V" .. multiline_pattern)
  vim.opt.hlsearch = true
  vim.fn.setreg("o", temp)
end

vim.keymap.set("x", "*", function() v_set_search("/") end)
vim.keymap.set("x", "#", function() v_set_search("?") end)

-- Add word under cursor to search pattern
vim.keymap.set("n", "<leader>*", "/<C-R>/\\|\\<<C-R><C-W>\\><CR><C-O>")
vim.keymap.set("n", "<leader>?", "/<C-R>/\\|")

-- Search highlight behaviour
local clear_search_hl = vim.api.nvim_create_augroup("ClearSearchHL", {})
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "/,?",
  command = "set hlsearch",
  group = clear_search_hl,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set nohlsearch",
  group = clear_search_hl,
})
vim.keymap.set("n", "n", "<CMD>set hlsearch<CR>n")
vim.keymap.set("n", "N", "<CMD>set hlsearch<CR>N")
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR><Esc>")

-- List search matches in curret buffer
vim.keymap.set("n", "<leader>/", function()
  vim.cmd([[execute 'vimgrep /' . @/ . '/g %']])
  vim.cmd("bot copen")
end)

-- Grep for word under cursor
vim.keymap.set("x", "<Leader>#", function()
  local temp = vim.fn.getreg("o")
  vim.cmd([[ normal! "oy ]])
  local selection = vim.fn.getreg("o")
  vim.fn.setreg("/", selection)
  vim.opt.hlsearch = true
  vim.cmd("sil! gr! -F '" .. selection .. "'")
  vim.cmd("bot copen")
  vim.fn.setreg("o", temp)
end)

-- Search inside selection
vim.keymap.set("x", "<leader>/", "<Esc>/\\%V")

-- Highlight symbol under cursor TODO doesn't clear or navigate
-- vim.keymap.set("n", "*", vim.lsp.buf.document_highlight)
