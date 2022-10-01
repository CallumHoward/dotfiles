vim.cmd("colorscheme tokyonight")

vim.opt.mouse = "a" -- Enable mouse

vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("s", "kj", "<ESC>")

vim.opt.number = true -- Set numbered lines
vim.opt.relativenumber = true
vim.opt.list = true
-- vim.opt.signcolumn = "number" -- merge signcolumn with number column
vim.opt.signcolumn = "yes" -- always show signcolumn
vim.opt.shortmess = vim.opt.shortmess + "I" -- Don't show welcome message
vim.opt.shortmess = vim.opt.shortmess + "c" -- Don't pass messages to |ins-completion-menu|.
vim.opt.showcmd = false -- don't show extra info at end of command line
vim.opt.ruler = false -- don't show character and line numbers

vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.softtabstop = 2 -- Change the number of space characters inserted for indentation
vim.opt.smartindent = true -- indent based on filetype
vim.opt.linebreak = true -- wrap long lines at characters in 'breakat'
vim.opt.breakindent = true -- wrapped text is indented
vim.cmd("set briopt=sbr,shift:0,min:20") -- config for breakindent
vim.opt.showbreak = "↳ "
vim.opt.breakat = " ,{"
vim.cmd("set cpoptions+=n")
vim.cmd("set scrolloff=1")

vim.opt.pumheight = 5 -- completion menu size
vim.opt.pumblend = 9 -- transparency for completion menu
vim.opt.winblend = 9 -- transparency for floating windows
vim.opt.winminheight = 0
vim.opt.winminwidth = 0

vim.opt.ignorecase = true -- for search patterns
vim.opt.smartcase = true -- don't ignore case if capital is used

vim.opt.undofile = true
vim.opt.wildmode = "longest,full"
vim.opt.wildignorecase = true

vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.splitbelow = true -- Horizontal splits will automatically be below

vim.opt.diffopt = "internal,filler,closeoff,iwhite,vertical,algorithm:patience,indent-heuristic"
vim.opt.fillchars = "diff:╱"

vim.opt.iskeyword = vim.opt.iskeyword + "-" -- treat dash separated words as a word text object"
vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers

vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.termguicolors = true -- set term gui colors most terminals support this
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.backup = false -- This is recommended by coc
vim.opt.writebackup = false -- This is recommended by coc
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Faster mapping timeout

vim.g.foldmethod = "expr"
vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
