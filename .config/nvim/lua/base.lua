vim.cmd("colorscheme tokyonight")

vim.o.mouse = "a" -- Enable your mouse

vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "kj", "<ESC>", { noremap = true, silent = true })

vim.wo.number = true -- Set numbered lines
vim.wo.relativenumber = true
vim.wo.list = true
vim.cmd("set shortmess+=I") -- Don't show welcome message
vim.cmd("set shortmess+=c") -- Don't pass messages to |ins-completion-menu|.
vim.cmd("set noshowcmd")
vim.cmd("set noruler")

vim.cmd("set expandtab") -- Converts tabs to spaces
vim.cmd("set shiftwidth=2") -- Change the number of space characters inserted for indentation
vim.cmd("set tabstop=2") -- Insert 2 spaces for a tab
vim.cmd("set softtabstop=2") -- Change the number of space characters inserted for indentation
vim.bo.smartindent = true -- indent based on filetype
vim.wo.linebreak = true -- wrap long lines at characters in 'breakat'
vim.wo.breakindent = true -- wrapped text is indented
vim.cmd("set briopt=sbr,shift:8,min:20") -- config for breakindent
vim.cmd('let &showbreak="↳ "')
vim.cmd('let &breakat=" ,{"')
vim.cmd("set cpoptions+=n")
vim.cmd("set scrolloff=1")

vim.o.pumheight = 5 -- completion menu size
vim.o.pumblend = 9 -- transparency for completion menu
vim.o.winblend = 9 -- transparency for floating windows

vim.cmd("set ignorecase") -- for search patterns
vim.cmd("set smartcase") -- don't ignore case if capital is used

vim.o.undofile = true
vim.cmd("set wildmode=longest,full")
vim.cmd("set wildignorecase")
vim.cmd("set wildoptions=pum,tagfile")

vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.splitbelow = true -- Horizontal splits will automatically be below

vim.cmd("set inccommand=split") -- Make substitution work in realtime

vim.cmd("set iskeyword+=-") -- treat dash separated words as a word text object"
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers

-- vim.o.title = true
-- TERMINAL = vim.fn.expand('$TERMINAL')
-- vim.cmd('let &titleold="'..TERMINAL..'"')
-- vim.o.titlestring="%t"
-- vim.cmd('autocmd BufEnter * let &titlestring = " " . expand("%:t")')

vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- Faster mapping timeout

-- disable automatic comment insertion
vim.cmd("autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
-- vim.cmd('set formatoptions-=c formatoptions-=r formatoptions-=o')

require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
  indent = {
    enable = true,
  },
})

-- TODO does not work, set in extra.vim for now
-- vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
vim.g.foldmethod = "expr"
vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd("set nofoldenable")
