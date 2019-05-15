" base.vim
" Vim base configuration
" Callum Howard

" colorscheme
if exists("neovim_dot_app") | colo OceanicNext | else | colo neodark | endif

set mouse=a

"language en_AU

inoremap kj <Esc>
"xnoremap kj <Esc>  " interferes with visual block mode
snoremap kj <Esc>

set number                      " enable line numbers
set list                        " display hidden characters
set shortmess+=I                " disable splash screen message
set noshowcmd
set noruler

set expandtab                   " expand tabs to spaces
set shiftwidth=4                " spaces to shift when re-indenting
set tabstop=4                   " number of spaces to insert when tab is pressed
set softtabstop=4               " backspace deletes indent
set smartindent                 " indent based on filetype
set linebreak                   " wrap long lines at characters in 'breakat'
set breakindent                 " wrapped text is indented
set briopt=sbr,shift:8,min:20   " config for breakindent
let &showbreak='↳ '
let &breakat=' ,{'
set cpoptions+=n

set pumheight=5                 " maximum number of items in completion popup

set ignorecase                  " for search patterns
set smartcase                   " don't ignore case if capital is used

set path+=~/.config/nvim        " always have config files in path
set path+=**                    " recursive filepath completion
set wildmode=list:longest,full  " show options if completion is ambiguous
set wildignorecase              " ignore case in commandline filename completion
set undofile                    " undo persists after closing file

set splitright                  " puts new vsplit windows to the right of the current
set splitbelow                  " puts new split windows to the bottom of the current

set icm=nosplit                 " live preview for substitution

set fcs=fold:—                  " verticle split is just bg color
set foldcolumn=0                " visual representation of folds
set foldmethod=syntax
set foldnestmax=1
set nofoldenable
set foldopen-=block

set rulerformat=%=%P
nnoremap <silent><ScrollWheelUp> :setl ruler nornu<CR><ScrollWheelUp>
nnoremap <silent><ScrollWheelDown> :setl ruler nornu<CR><ScrollWheelDown>
autocmd CursorHold * set noruler

" diff config
set diffopt+=iwhite " ignore whitespace
set diffopt+=algorithm:patience " use patience diff algorithm

" disable foldcolumn for diffs
autocmd FilterWritePre * if &diff | set fdc=0 | endif

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set title for tmux
if exists('$TMUX')
    autocmd WinEnter,BufWinEnter,FocusGained * call system('tmux rename-window ' . expand('%:t'))
endif

if has('nvim') && !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
    function! SetTerminalTitle() abort
        if bufname('%') != '' && bufname('%') !~ '^term'
            let titleString = 'file://'.expand('%:p:gs/\ /%20/')
        else
            let titleString = 'file://'.expand(getcwd())
            return
        endif

        " this is the format Terminal.app expects when setting the proxy icon
        if exists('$TMUX')
            let args = 'Ptmux;]7;'.titleString.'\\'
        else
            let args = ']7;'.titleString.''
        endif

        let cmd = 'call chansend(2, "'.args.'")'
        execute cmd
    endfunction

    autocmd WinEnter,BufWinEnter,FocusGained * call SetTerminalTitle()
endif

" check for and load file changes
autocmd WinEnter,BufWinEnter,FocusGained * checktime

" update diff on write NOTE: doesn't appear to work
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" set files with .tem extension as C++ Template files
autocmd BufNewFile,BufFilePre,BufRead *.tem setlocal filetype=cpp

" set files with .shader extension as glsl shader files
autocmd BufNewFile,BufFilePre,BufRead *.shader setlocal filetype=glsl

" relative number configuration
autocmd FocusLost,InsertEnter,WinLeave * if &ma && &ft !~ 'markdown\|text' && &bt != 'nofile' | :setl nornu | endif
autocmd FocusGained,InsertLeave,WinEnter,BufRead * if &ma && &ft !~ 'markdown\|text' && &bt != 'nofile' | :setl nu rnu | endif

" cursorline configuration
autocmd FocusLost,InsertEnter,WinLeave,BufWinLeave,CmdwinLeave * setl nocul
autocmd FocusGained,InsertLeave,WinEnter,BufWinEnter,CmdwinEnter * setl cul

"set lazyredraw
"autocmd VimResized,FocusGained * redraw

" enable omnicompletion
"set tags+=~/.config/nvim/systags
autocmd Filetype * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" automatically save and load views (including cursor positions and folds)
"au BufWinLeave ?* mkview!
"au BufWinEnter ?* silent! loadview
"autocmd BufWinLeave * if expand("%") != "" | mkview | endif
"autocmd BufWinEnter * if expand("%") != "" | loadview | endif

" jump to the previous cursor position in the file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" manpager
hi link manFooter Title
