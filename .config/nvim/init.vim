" ==== dein Scripts ====
set runtimepath^=/Users/callumhoward/.dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('/Users/callumhoward/.dein/'))

" Add or remove plugins here:
call dein#add('Shougo/dein.vim')                    " plugin manager
call dein#add('haya14busa/dein-command.vim')        " dein bindings

" completion activation events
let s:ces = ['InsertEnter', 'FocusLost', 'CursorHold']

" completion plugins
call dein#add('Shougo/neosnippet.vim',
            \ {'on_event': s:ces})                  " snippet expansion
call dein#add('~/neosnippet-snippets',
            \ {'on_event': s:ces})                  " snippet collection
call dein#add('Shougo/echodoc.vim',
            \ {'on_event': s:ces})                  " function signatures in status
call dein#add('Shougo/deoplete.nvim',
            \ {'on_event': s:ces})                  " auto popup completion
call dein#add('wellle/tmux-complete.vim',
            \ {'on_event': s:ces})                  " tmux window completion source
call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
call dein#add('zchee/deoplete-jedi')                " can't be lazy
call dein#add('artur-shaik/vim-javacomplete2',      {'on_ft': 'java'})
call dein#add('zchee/deoplete-clang')               " can't be lazy
"call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})

" feature plugins
call dein#add('neomake/neomake')
"            \ {'on_event': ['BufWritePre', 'FocusLost', 'CursorHold']})
call dein#add('airblade/vim-gitgutter')             " line git status
call dein#add('kshenoy/vim-signature')              " marks in signs column
call dein#add('ludovicchabant/vim-gutentags')       " automatic tagfile generation
call dein#add('lambdalisue/gina.vim',               {'on_cmd': 'Gina'})
call dein#add('majutsushi/tagbar',                  {'on_cmd': 'TagbarToggle'})
call dein#add('rhysd/vim-clang-format',             {'on_ft': ['c', 'cpp']})
call dein#add('alepez/vim-llvmcov',                 {'on_ft': ['c', 'cpp']})
call dein#add('valloric/MatchTagAlways',            {'on_ft': 'html'})
call dein#add('alvan/vim-closetag',                 {'on_ft': 'html'})
call dein#add('lotabout/skim',                      {'build': './install --all', 'merged': 0})
call dein#add('lotabout/skim.vim',                  {'depends': 'skim'})
call dein#add('tpope/vim-abolish')                  " deal with word variants
"call dein#add('cloudhead/neovim-fuzzy')
"call dein#add('yuttie/comfortable-motion.vim')
call dein#add('bounceme/poppy.vim')                 " rainbow parens (set to one level)
call dein#add('dahu/LearnVim')

" keybindings
call dein#add('tpope/vim-rsi', {'on_event': s:ces}) " enable readline key mappings
call dein#add('takac/vim-hardtime')                 " disable rapid hjkl repeat

" colorschemes
call dein#add('~/neodark')
call dein#add('cocopon/iceberg.vim')
call dein#add('mhartington/oceanic-next')
call dein#add('w0ng/vim-hybrid')

" syntax plugins
call dein#add('rust-lang/rust.vim')
call dein#add('sophacles/vim-processing',           {'on_ft': 'processing'})
call dein#add('wavded/vim-stylus')                  " can't be lazy
call dein#add('neovimhaskell/haskell-vim')          " can't be lazy
"call dein#add('octol/vim-cpp-enhanced-highlight')   " can't be lazy
call dein#add('tikhomirov/vim-glsl')
call dein#add('arakashic/chromatica.nvim')   " can't be lazy
let g:cpp_experimental_template_highlight = 1
let g:cpp_class_scope_highlight = 1

call dein#end()
filetype plugin indent on
let g:dein#install_log_filename = '/Users/callumhoward/.dein/dein_install.log'
" ==== end dein Scripts ====

" base configuration
if exists("neovim_dot_app") | colo OceanicNext | else | colo neodark | endif
syntax on
set mouse=a

language en_AU

inoremap kj <Esc>
set number          " enable line numbers
set list            " display hidden characters
set shortmess+=I    " disable splash screen message
set noshowcmd
set noruler

set expandtab       " expand tabs to spaces
set shiftwidth=4    " spaces to shift when re-indenting
set tabstop=4       " number of spaces to insert when tab is pressed
set softtabstop=4   " backspace deletes indent
set smartindent     " indent based on filetype
"set nowrap          " don't wrap text
set linebreak       " wrap long lines at characters in 'breakat'
set breakindent     " wrapped text is indented
set briopt=sbr,shift:8,min:20
let &showbreak='↳ '
let &breakat=' ^I,{'

set pumheight=5     " maximum number of items in completion popup

set ignorecase      " for search patterns
set smartcase       " don't ignore case if capital is used

set path+=**        " recursive filepath completion
set wildignorecase  " ignore case in commandline filename completion
set undofile        " undo persists after closing file
"set backup          " backup files

set splitright      " puts new vsplit windows to the right of the current
set splitbelow      " puts new split windows to the bottom of the current

set icm=nosplit     " live preview for substitution

set fcs=fold:-      " verticle split is just bg color
set foldcolumn=0    " visual representation of folds
set foldmethod=syntax
set foldnestmax=1
set nofoldenable

" disable foldcolumn for diffs
autocmd FilterWritePre * if &diff | set fdc=0 | endif

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set title for tmux
autocmd WinEnter,BufWinEnter,FocusGained * call system('tmux rename-window ' . expand('%:t'))

" check for and load file changes
autocmd WinEnter,BufWinEnter,FocusGained * checktime

" update diff on write NOTE: doesn't appear to work
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" set files with .tem extension as C++ Template files
autocmd BufNewFile,BufFilePre,BufRead *.tem setlocal filetype=cpp

"set lazyredraw
"autocmd VimResized,FocusGained * redraw

" wrapped line movement mappings (adds larger jumps to jumplist)
nnoremap <expr> j v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

tnoremap <C-A>o <C-\><C-N><C-W><C-W>

" prevent jump after searching word under cursor with # and *, clear with Escape
nnoremap <silent> # :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>w?<CR>
nnoremap <silent> * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
nnoremap <silent> g# :let @/ = expand('<cword>')\|set hlsearch<CR>w?<CR>
nnoremap <silent> g* :let @/ = expand('<cword>')\|set hlsearch<CR>
nnoremap <silent> <Esc> :noh<CR>

" unimpaired quickfix mappings
nnoremap <silent> <leader>q :cw<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" unimpaired location list mappings
nnoremap <silent> <leader>l :cw<CR> :lw<CR>
nnoremap <silent> [l :lprevious<CR>zmzv
nnoremap <silent> ]l :lnext<CR>zmzv
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" unimpaired buffer mappings
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" accordion expand traversal of folds
nnoremap <silent> z] :<C-u>silent! normal! zc<CR>zjzozz
nnoremap <silent> z[ :<C-u>silent! normal! zc<CR>zkzo[zzz

" insert closing curly brace
"inoremap {<CR> {<CR>}<Esc>O
inoremap <expr> {<Enter> <SID>CloseBracket()

" substitution mappings
nnoremap <leader>; :%s/;$/ {}
xnoremap <leader>; :s/;$/ {}
nnoremap <leader><Space> :%s/\s\+$//e<CR>
nnoremap <leader>s :%s///g<Left><Left>
xnoremap <leader>s :s///g<Left><Left>

" gina mappings
nnoremap <silent> <leader>b :Gina browse : --scheme=blame<CR>

" dot command works on ranges
xnoremap . :normal .<CR>

" don't close split when deleting a buffer
command Bd bp\|bd #

" relative number configuration
autocmd FocusLost,InsertEnter,WinLeave ?* if &ma && &ft !~ 'markdown\|text' && &bt != 'nofile' | :setl nornu | endif
autocmd FocusGained,InsertLeave,WinEnter,BufRead ?* if &ma && &ft !~ 'markdown\|text' && &bt != 'nofile' | :setl nu rnu | endif

" cursorline configuration
autocmd FocusLost,InsertEnter,WinLeave,BufWinLeave,CmdwinLeave :setl nocul | endif
autocmd FocusGained,InsertLeave,WinEnter,BufWinEnter,CmdwinEnter :setl cul | endif

" netrw filebrowser config
let g:netrw_winsize = -28               " absolute width of netrw window
let g:netrw_banner = 0                  " do not display info on the top of window
let g:netrw_liststyle = 3               " tree-view
let g:netrw_sort_sequence = '[\/]$,*'   " sort so directories on the top, files below
let g:netrw_browse_split = 4            " use the previous window to open file
let g:netrw_hide = 1                    " don't show hidden files (use gh to toggle)
let g:netrw_list_hide='^\.,\.dSYM/'
nnoremap <silent> <Leader>\ :call ToggleNetrw()<CR>
cabbrev cd. <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'lcd %:p:h\|pwd' : 'cd.')<CR>

let g:netrw_is_open=0
function! ToggleNetrw()
    if g:netrw_is_open
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:netrw_is_open=0
    else
        let g:netrw_is_open=1
        silent Lexplore
    endif
endfunction

" automatically save and load views (including cursor positions and folds)
"au BufWinLeave ?* mkview!
"au BufWinEnter ?* silent! loadview
"autocmd BufWinLeave * if expand("%") != "" | mkview | endif
"autocmd BufWinEnter * if expand("%") != "" | loadview | endif

" jump to the previous cursor position in the file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" shared clipboard (too slow)
"augroup sharedclipb
"    au!
"    autocmd FocusLost * wshada
"    autocmd FocusGained * sleep 1 | rshada
"augroup END

" use Ag/Rg for grep if available
if executable('rg') | set gp=rg\ -S\ --vimgrep\ --no-heading gfm=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m|
elseif executable('ag') | set gp=ag\ --nogroup\ --nocolor | endif
com! -nargs=+ -complete=file -bar Rg sil! gr! <args>|cw|redr!|let @/="<args>"|set hls
com! -nargs=+ -complete=file -bar Ag sil! gr! <args>|cw|redr!|let @/="<args>"|set hls

" grep for word under cursor
nmap <Leader># #:sil! gr! "\b<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>
nmap <Leader>* #:sil! gr! "\b<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>

" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
    return filter(map(copy(v:oldfiles), 'fnamemodify(v:val, ":~:.")'), 'v:val =~ a:ArgLead')
endfunction

" browse most recently opened files with :O or :o
command! -nargs=? -complete=customlist,<sid>MRUComplete O if empty("<args>") | :browse oldfiles | else | :e <args> | endif
cabbrev o <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'O' : 'o')<CR>

" fuzzy command mappings
cabbrev vf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sf' : 'vf')<CR>
cabbrev vsf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sf' : 'vsf')<CR>
cabbrev ef <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'fin' : 'ef')<CR>

" enable omnicompletion
set tags+=~/.config/nvim/systags
autocmd Filetype * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" use deoplete completion
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns') | let g:deoplete#omni#input_patterns = {} | endif
"let g:deoplete#sources._ = ['tag', 'member', 'file', 'omni', 'buffer', 'tmux-complete']
"let g:deoplete#auto_complete_start_length = 0
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'

" gutentags config
let g:gutentags_cache_dir = '~/.local/share/nvim/tags/'

" neosnippet key-mappings
nmap <C-k>     i<Plug>(neosnippet_expand_or_jump)
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior
let g:neosnippet#expand_word_boundary = 1
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
xmap <TAB> <Plug>(neosnippet_expand_target)

" conceal neosnippet markers
set conceallevel=2
set concealcursor=niv

" allow automatic function signature expansion
let g:neosnippet#enable_completed_snippet=1

" vim-closetag config
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.md"

function! s:CloseBracket()
    let line = getline('.')
    if line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction

" gitgutter config
set updatetime=500
hi GitGutterAdd ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1 cterm=bold
hi GitGutterChangeDelete ctermfg=1
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_removed_first_line =  '˙'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

" signature config
let g:SignatureMap = {'Leader' : 'm'}   " disable extra mappings
let g:SignatureMarkTextHLDynamic = 1    " keep gitgutter highlight color
let g:SignatureForceMarkPlacement = 1   " use :delm x to delete mark x
let g:SignatureMarkTextHL = 'ErrorMsg'

" vim-clang-format config
let g:clang_format#command = '/usr/local/opt/llvm/bin/clang-format'
let g:clang_format#code_style = "llvm"
let g:clang_format#auto_formatexpr = 1
let g:clang_format#style_options = {
        \ "AccessModifierOffset" : -4,
        \ "AlignAfterOpenBracket" : "DontAlign",
        \ "AlignOperands" : "false",
        \ "AllowShortBlocksOnASingleLine" : "true",
        \ "AllowShortCaseLabelsOnASingleLine" : "true",
        \ "AllowShortFunctionsOnASingleLine" : "true",
        \ "AllowShortIfStatementsOnASingleLine" : "true",
        \ "AllowShortLoopsOnASingleLine" : "true",
        \ "AlwaysBreakTemplateDeclarations" : "true",
        \ "ConstructorInitializerIndentWidth" : "8",
        \ "ContinuationIndentWidth" : "8",
        \ "IndentWidth" : "4",
        \ "SpacesBeforeTrailingComments" : "2",
        \ "Standard" : "C++11",
        \ "TabWidth" : "4"}

" Chromatica config
let g:chromatica#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'

" neomake config
"autocmd! BufWritePost * if &ft == 'rust' | Neomake! cargo | else | Neomake | endif
hi NeomakeError cterm=underline
hi NeomakeWarning cterm=underline
hi NeomakeInfo cterm=underline
hi NeomakeMessage cterm=underline
hi NeomakeErrorSign ctermfg=1 ctermbg=none
hi NeomakeWarningSign ctermfg=9 ctermbg=none
hi NeomakeInfoSign ctermfg=5 ctermbg=none
hi NeomakeMessageSign ctermfg=5 ctermbg=none
let g:neomake_error_sign = {'text': '-!', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '-!', 'texthl': 'NeomakeWarningSign'}
let g:neomake_info_sign = {'text': '-i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_message_sign = {'text': '->', 'texthl': 'NeomakeMessageSign'}
let g:neomake_c_enabled_makers = ['clang', 'clangtidy']
let g:neomake_c_clangtidy_args = ['-extra-arg=-std=c99', '-checks=\*']
let g:neomake_c_clang_args = ['-std=c99', '-Wextra', '-Weverything', '-pedantic', '-Wall', '-Wno-unused-parameter', '-g']
let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy']
let g:neomake_cpp_clangtidy_args = ['-checks=\*',
            \'-extra-arg=-std=c++14 -I/usr/local/opt/boost/include -I~/range-v3/include -I~/Documents/Cinder.git/include']
let g:neomake_cpp_clang_args = ['-std=c++1y', '-Wextra', '-Weverything', '-pedantic', '-Wall', '-Wno-unused-parameter', '-Wno-c++98-compat', '-g',
            \'-I/usr/local/opt/boost/include', '-I~/Documents/Cinder.git/include', '-I~/range-v3/include']
let g:neomake_haskell_enabled_makers = ['hlint', 'ghcmod']

" deoplete-clang config
let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/lib/clang'
let g:deoplete#sources#clang#std = {'c': 'c11', 'cpp': 'c++14', 'objc': 'c11', 'objcpp': 'c++1z'}
let g:deoplete#sources#clang#flags = ['-I/usr/local/opt/boost/include', '-I~/Documents/Cinder.git/include', '-I~/range-v3/include']

" echodoc config
let g:echodoc_enable_at_startup = 1
set shortmess+=c            " don't show completion number in status
set completeopt-=preview    " don't open preview window when completing
set noshowmode              " disable status mode indicator and replace with a fake
autocmd InsertEnter * echohl ModeMSG | echo "-- INSERT --" | echohl None
autocmd InsertLeave * echo ""

" tagbar config
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_compact = 1

" diff config
set diffopt+=iwhite "ignore whitespace

" poppy config
au CursorMoved,CursorMovedI * call PoppyInit()
let g:poppyhigh = ['Ignore']
let g:poppy_point_enable = 1

" hardtime config
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
let g:hardtime_showmsg = 1

let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
let g:list_of_insert_keys = []
