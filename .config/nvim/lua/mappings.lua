-- Jump to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<C-W>d", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end)
vim.keymap.set("n", "<C-W><C-D>", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end)

-- Jump to declaration
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<C-W>D", function()
  vim.cmd("split")
  vim.lsp.buf.declaration()
end)

-- Jump to implementation
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<C-]>", vim.lsp.buf.implementation)
vim.keymap.set("n", "<C-W>]", function()
  vim.cmd("split")
  vim.lsp.buf.implementation()
end)
vim.keymap.set("n", "<C-W><C-]>", function()
  vim.cmd("vsplit")
  vim.lsp.buf.implementation()
end)

-- Refactor and fix
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Documentation
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help)

-- Markdown link shortcut
vim.keymap.set("n", "<C-K>", "ysiw]'>a()<Left>", { remap = true })
vim.keymap.set("x", "<C-K>", "S]'>a()<Left>", { remap = true })

-- Diagnostics
local float_opts = { scope = "line", header = "" }
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = float_opts })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = float_opts })
end)
vim.keymap.set("n", "<leader>cd", function()
  vim.diagnostic.open_float(float_opts)
end)
vim.keymap.set("n", "<leader>cD", function()
  vim.diagnostic.config({ virtual_text = false })
end)

-- Highlight symbol under cursor TODO doesn't clear or navigate
-- vim.keymap.set("n", "*", vim.lsp.buf.document_highlight)

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

vim.keymap.set("n", "#", function()
  hl_cword(true, true)
end)
vim.keymap.set("n", "g#", function()
  hl_cword(true, true)
end)
vim.keymap.set("n", "*", function()
  hl_cword(false, false)
end)
vim.keymap.set("n", "g*", function()
  hl_cword(false, false)
end)

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

vim.keymap.set("x", "*", function()
  v_set_search("/")
end)
vim.keymap.set("x", "#", function()
  v_set_search("?")
end)

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

-- Copy buffer relative filepath
vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  vim.notify(vim.fn.expand("%"), "info", { title = "Copied buffer path" })
end)

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

-- Swap mark keys
vim.keymap.set("n", "'", "`")
vim.keymap.set("n", "`", "'")

-- Select last pasted
vim.keymap.set("n", "gV", "`[v`]")

-- Add word under cursor to search pattern

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

-- Mappings for searching word under cursor

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

-- Search inside selection
vim.keymap.set("x", "<leader>/", "<Esc>/\\%V")

-- Global mappings
vim.keymap.set({ "n", "x" }, "<leader>gn", ":g//norm ")
vim.keymap.set({ "n", "x" }, "<leader>gd", ":g//norm ")
vim.keymap.set({ "n", "x" }, "<leader>gD", ":g//norm ")

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
