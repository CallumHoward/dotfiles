local vo = vim.opt

vo.mouse = "a" -- Enable mouse

vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("s", "kj", "<ESC>")

vo.number = true -- Set numbered lines
vo.relativenumber = true
vo.list = true
-- vo.signcolumn = "number" -- Merge signcolumn with number column
vo.signcolumn = "yes" -- Always show signcolumn
vo.shortmess:append("I") -- Don't show welcome message
vo.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|.
vo.showcmd = false -- Don't show extra info at end of command line
vo.ruler = false -- Don't show character and line numbers

vo.expandtab = true -- Converts tabs to spaces
vo.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vo.tabstop = 2 -- Insert 2 spaces for a tab
vo.softtabstop = 2 -- Change the number of space characters inserted for indentation
vo.smartindent = true -- Indent based on filetype
vo.linebreak = true -- Wrap long lines at characters in 'breakat'
vo.breakindent = true -- Wrapped text is indented
vo.breakindentopt = "sbr,shift:0,min:20" -- Config for breakindent
vo.showbreak = "↳ "
vo.breakat = " ,{"
vo.cpoptions:append("n") -- Column calc for wrapped lines
vo.scrolloff = 1 -- Leave 1 line visible at the top and bottom of window when scrolling

vo.pumheight = 5 -- Completion menu size
vo.pumblend = 9 -- Transparency for completion menu
vo.winblend = 9 -- Transparency for floating windows
vo.winminheight = 0
vo.winminwidth = 0

vo.ignorecase = true -- For search patterns
vo.smartcase = true -- Don't ignore case if capital is used

vo.undofile = true
vo.wildmode = "longest,full"
vo.wildignorecase = true

vo.splitright = true -- Vertical splits will automatically be to the right
vo.splitbelow = true -- Horizontal splits will automatically be below

vo.diffopt = "internal,filler,closeoff,iwhite,vertical,algorithm:patience,indent-heuristic"
vo.fillchars = "diff:╱"

vo.iskeyword:append("-") -- Treat dash separated words as a word text object"
vo.hidden = true -- Required to keep multiple buffers open multiple buffers

vo.fileencoding = "utf-8" -- The encoding written to file
vo.termguicolors = true -- Set term gui colors most terminals support this
vo.cursorline = true -- Enable highlighting of the current line
vo.backup = false -- This is recommended by coc
vo.writebackup = false -- This is recommended by coc
vo.updatetime = 300 -- Faster completion
vo.timeoutlen = 500 -- Faster mapping timeout

vo.foldmethod = "expr"
vo.foldexpr = "nvim_treesitter#foldexpr()"
vo.foldenable = false
