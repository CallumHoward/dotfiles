" plugins.vim
" Neovim plugin configuration
" Callum Howard

" ==== dein Scripts ====
set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " Add or remove plugins here:
    call dein#add('Shougo/dein.vim')                    " plugin manager
    call dein#add('haya14busa/dein-command.vim')        " dein bindings
    call dein#add('wsdjeg/dein-ui.vim')                 " dein update ui

    " completion activation events
    let s:ces = ['InsertEnter', 'FocusLost', 'CursorHold']

    " completion plugins
    call dein#add('Shougo/neosnippet.vim', {'on_event': s:ces})                  " snippet expansion
    call dein#add('~/neosnippet-snippets', {'on_event': s:ces})                  " snippet collection
    call dein#add('Shougo/echodoc.vim', {'on_event': s:ces})                  " function signatures in status
    "call dein#add('Shougo/deoplete.nvim', {'on_event': s:ces})                  " auto popup completion
    call dein#add('wellle/tmux-complete.vim')                  " tmux window completion source
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
    call dein#add('Shougo/neco-syntax')
    "call dein#add('zchee/deoplete-jedi')                " can't be lazy
    "call dein#add('artur-shaik/vim-javacomplete2',      {'on_ft': 'java'})
    "call dein#add('zchee/deoplete-clang')               " can't be lazy
    "call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})
    "call dein#add('autozimu/LanguageClient-neovim', {
    "    \ 'rev': 'next',
    "    \ 'build': 'bash install.sh',
    "    \ })
    call dein#add('neoclide/coc.nvim', {'merge':0, 'build': './install.sh nightly'})

    " feature plugins
    call dein#add('neomake/neomake')
    call dein#add('airblade/vim-gitgutter')             " line git status
    call dein#add('kshenoy/vim-signature')              " marks in signs column
    "call dein#add('liuchengxu/vista.vim')               " language server aware tags
    call dein#add('majutsushi/tagbar',                  {'on_cmd': 'TagbarToggle'})
    call dein#add('valloric/MatchTagAlways',            {'on_ft': ['html', 'xml', 'jsx']})
    call dein#add('alvan/vim-closetag',                 {'on_ft': ['html', 'xml', 'jsx']})
    call dein#add('tpope/vim-abolish')                  " deal with word variants
    "call dein#add('cloudhead/neovim-fuzzy')
    "call dein#add('yuttie/comfortable-motion.vim')
    call dein#add('bounceme/poppy.vim')                 " rainbow parens (set to one level)
    call dein#add('tmhedberg/SimpylFold')               " fold python classes and functions
    call dein#add('chrisjohnson/vim-foldfunctions')     " only fold functions
    call dein#add('junegunn/goyo.vim', {'on_cmd': 'Goyo'})  " focus mode
    call dein#add('junegunn/limelight.vim')             " focus mode
    call dein#add('rbgrouleff/bclose.vim')              " dependency for ranger.vim
    call dein#add('wellle/targets.vim')                 " extended text objects
    call dein#add('michaeljsmith/vim-indent-object')    " indent text object
    call dein#add('CallumHoward/vim-interestingwords')  " multi keyword highlight
    call dein#add('idbrii/vim-tagimposter')             " mappings can add to taglist
    call dein#add('joeytwiddle/sexy_scroller.vim')
    call dein#add('rhysd/git-messenger.vim', {
                \   'lazy' : 1,
                \   'on_cmd' : 'GitMessenger',
                \   'on_map' : '<Plug>(git-messenger)',
                \ })

    " wrap external tools
    call dein#add('ludovicchabant/vim-gutentags')       " automatic tagfile generation
    call dein#add('lambdalisue/gina.vim',               {'on_cmd': 'Gina'})
    call dein#add('rhysd/vim-clang-format',             {'on_ft': ['c', 'cpp']})
    "call dein#add('alepez/vim-llvmcov',                 {'on_ft': ['c', 'cpp']})
    "call dein#add('lotabout/skim',                      {'build': './install --all', 'merged': 0})
    "call dein#add('CallumHoward/skim.vim',              {'depends': 'skim'})
    call dein#add('junegunn/fzf',                       { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim',                   { 'depends': 'fzf' })
    call dein#add('sakhnik/nvim-gdb')                   " gdb and lldb wrapper
    call dein#add('francoiscabrol/ranger.vim')          " ranger as netrw replacement
    call dein#add('CallumHoward/vim-tbone')             " send text to tmux pane
    call dein#add('CoatiSoftware/vim-sourcetrail',      {'on_cmd': 'SourcetrailStartServer'})
    "call dein#add('yamahigashi/sendtomaya.vim')
    call dein#add('romainl/vim-devdocs')

    " keybindings
    call dein#add('tpope/vim-surround.git',             {'on_event': s:ces})
    call dein#add('tpope/vim-repeat',                   {'on_event': s:ces})
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
    call dein#add('tikhomirov/vim-glsl')
    call dein#add('yuezk/vim-js')                       " can't be lazy
    call dein#add('maxmellon/vim-jsx-pretty')           " can't be lazy
    "call dein#add('arakashic/chromatica.nvim')          " can't be lazy
    "call dein#add('octol/vim-cpp-enhanced-highlight')   " can't be lazy

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
let g:dein#install_log_filename = '~/.cache/dein/dein_install.log'
" ==== end dein Scripts ====

" netrw filebrowser config
let g:netrw_winsize = -28               " absolute width of netrw window
let g:netrw_banner = 0                  " do not display info on the top of window
let g:netrw_liststyle = 3               " tree-view
let g:netrw_sort_sequence = '[\/]$,*'   " sort so directories on the top, files below
let g:netrw_browse_split = 4            " use the previous window to open file
let g:netrw_hide = 1                    " don't show hidden files (use gh to toggle)
let g:netrw_list_hide='^\.,\.dSYM/'

" cscope
set cscopetag  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set csto=0  " check cscope for definition of a symbol before checking ctags
set cscopeverbose " show msg when any other cscope db added
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-  " show cscope results in quickfix

"" add the database pointed to by environment variable 
"if $CSCOPE_DB != "" | cs add $CSCOPE_DB | endif

"" add any cscope database in current directory
"if filereadable("cscope.out") | cs add cscope.out | endif

" ranger.vim config
let g:ranger_replace_netrw = 1          " open ranger when vim open a directory
let g:NERDTreeHijackNetrw = 0
let g:ranger_map_keys = 0
cabbrev ra <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ranger' : 'ra')<CR>
cabbrev va <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vs \| Ranger' : 'va')<CR>
cabbrev spa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'sp \| Ranger' : 'spa')<CR>
cabbrev tra <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabe \| Ranger' : 'tra')<CR>

" use deoplete completion
let g:deoplete#enable_at_startup = 0
if !exists('g:deoplete#omni#input_patterns') | let g:deoplete#omni#input_patterns = {} | endif
"let g:deoplete#sources._ = ['tag', 'member', 'file', 'omni', 'buffer', 'tmux-complete']
"let g:deoplete#auto_complete_start_length = 0
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'

" gutentags config
let g:gutentags_cache_dir = '~/.local/share/nvim/tags/'

" neosnippet key-mappings
nmap <C-k>     i<Plug>(neosnippet_expand_or_jump)
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" SuperTab like snippets behavior
let g:neosnippet#expand_word_boundary = 1
imap <expr><TAB> neosnippet#expandable()
            \ ? "\<Plug>(neosnippet_expand)" : pumvisible()
            \ ? "\<C-n>" : neosnippet#jumpable()
            \ ? "\<Plug>(neosnippet_jump)" : <SID>check_back_space()
            \ ? "\<TAB>" : coc#refresh()
smap <expr><TAB> neosnippet#expandable_or_jumpable()
            \ ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
xmap <TAB> <Plug>(neosnippet_expand_target)

" complete and close popup if visible else: break undo
"inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "<C-g>u<CR>"

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" conceal neosnippet markers
set conceallevel=2
set concealcursor=niv

" allow automatic function signature expansion
let g:neosnippet#enable_completed_snippet=1
let g:neosnippet#enable_optional_arguments=0

" vim-closetag config
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx,*.md"
let g:closetag_xhtml_filetypes = 'xml,xhtml,jsx,javascript.jsx,javascript.tsx'
let g:closetag_emptyTags_caseSensitive = 1

" vim match tag always config
let g:mta_filetypes = {
            \'javascript.jsx': 1,
            \'javascript.tsx': 1,
            \'html' : 1,
            \'xhtml' : 1,
            \'xml' : 1,
            \'jinja' : 1,
            \'django' : 1,
            \'htmldjango' : 1,
            \'eruby': 1
            \}

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
"let g:gitgutter_diff_args = '-w'
"let g:gitgutter_map_keys = 0

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
autocmd! BufWritePost * if &ft == 'cpp' && (isdirectory('xcode') || isdirectory('../xcode')) |
            \     Neomake xcode |
            \ elseif &ft == 'rust' && (filereadable('cargo.toml') || filereadable('../cargo.toml')) |
            \     Neomake cargo |
            \ else |
            \     Neomake |
            \ endif

let g:neomake_virtualtext_current_error = 0
let g:neomake_error_sign = {'text': '-!', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '-!', 'texthl': 'NeomakeWarningSign'}
let g:neomake_info_sign = {'text': '-i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_message_sign = {'text': '-i', 'texthl': 'NeomakeMessageSign'}
let g:neomake_c_enabled_makers = ['clang', 'clangtidy']
let g:neomake_c_clangtidy_args = ['-extra-arg=-std=c99', '-checks=\*']
let g:neomake_c_clang_args = ['-std=c99', '-Wextra', '-Weverything', '-pedantic', '-Wall', '-Wno-unused-parameter', '-g']
let g:neomake_cpp_enabled_makers = ['clang', 'cppcheck', 'clangcheck', 'clangtidy']
let g:neomake_cpp_clangcheck_args = [
            \ '-extra-arg=-I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include',
            \ ]
let g:neomake_cpp_clangtidy_args = ['-checks=\*', '-extra-arg=-std=c++1z',
            \ '-extra-arg=-I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include',
            \ ]
" -I/usr/local/opt/boost/include -I~/range-v3/include -I~/Documents/Cinder.git/include']
"let g:neomake_cpp_clang_exe = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++'
let g:neomake_cpp_clang_args = ['-std=c++1z', '-Wextra', '-Weverything', '-pedantic', '-Wall', '-Wno-unused-parameter', '-Wno-c++98-compat', '-g',
            \'-I/usr/local/opt/boost/include', '-I~/Documents/Cinder.git/include', '-I~/range-v3/include']
let g:neomake_javascript_enabled_makers = []
let g:neomake_haskell_enabled_makers = ['hlint', 'ghcmod']
let g:neomake_cpp_xcode_maker = {
            \ 'exe': 'xcwrapper',
            \ 'flags': ['-configuration Debug', '-quiet'],
            \ 'append_file': 0,
            \ 'errorformat': '%f:%l:%c:%.%#\ error:\ %m,%f:%l:%c:%.%#\ warning:\ %m,%-G%.%#',
            \ }
let g:neomake_python_pep8_exe = 'python3'
let g:neomake_python_python_exe = 'python3'
let g:neomake_python_enabled_makers = ['pep8', 'python']
hi NeomakeError cterm=underline
hi NeomakeWarning cterm=underline
hi NeomakeInfo cterm=underline
hi NeomakeMessage cterm=underline
hi NeomakeErrorSign ctermfg=1 ctermbg=none
hi NeomakeWarningSign ctermfg=9 ctermbg=none
hi NeomakeInfoSign ctermfg=5 ctermbg=none
hi NeomakeMessageSign ctermfg=5 ctermbg=none

" deoplete-clang config
let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/lib/clang'
let g:deoplete#sources#clang#std = {'c': 'c11', 'cpp': 'c++14', 'objc': 'c11', 'objcpp': 'c++1z'}
let g:deoplete#sources#clang#flags = [
        \ '-I/usr/local/opt/boost/include',
        \ '-I~/Documents/Cinder.git/include',
        \ '-I~/range-v3/include',
        \ '-I/usr/local/Cellar/glew/2.1.0/include',
        \ '-I/usr/local/Cellar/glfw/3.2.1/include']

"nnoremap <leader>x :call LanguageClient_contextMenu()<CR>
"nnoremap <silent> gd :silent! TagImposterAnticipateJump \| call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

" CoC config
set hidden "if hidden is not set, TextEdit might fail.
" mapping to jump to tag under cursor

nmap <silent> gr #<Plug>(coc-references)
nnoremap <silent> gd <C-]>
nmap <silent> <C-]> :silent! TagImposterAnticipateJump<CR><Plug>(coc-definition)

nmap <silent> <leader>cy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-rename)
vmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>cx  <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>cl :<C-u>CocList<CR>
nnoremap <silent> <leader>cp :<C-u>CocListResume<CR>
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<CR>
nnoremap <silent> <leader>cj :<C-u>CocNext<CR>
nnoremap <silent> <leader>ck :<C-u>CocPrev<CR>
nnoremap <silent> <leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<CR>
nnoremap <leader>c?  :nmap <leader>c<CR>
nnoremap <leader>cc :CocCommand<CR>

" Use `[C` and `]C` to navigate diagnostics
nmap <silent> [C <Plug>(coc-diagnostic-prev)
nmap <silent> ]C <Plug>(coc-diagnostic-next)

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 CFormat :call CocAction('format')
command! -nargs=? CFold :call CocAction('fold', <f-args>)

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

augroup cocAuGroup
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd CursorHoldI * sil call CocActionAsync('showSignatureHelp')
augroup end

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
nnoremap <leader><C-i> :TagbarToggle<CR>

" vista config
let g:vista#renderer#enable_icon=0

" poppy config
if dein#is_sourced('poppy.vim')
    au CursorMoved,CursorMovedI * call PoppyInit()
    let g:poppyhigh = ['Ignore']
    let g:poppy_point_enable = 1
endif

" hardtime config
let g:hardtime_default_on = 0
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
let g:hardtime_showmsg = 1
let g:hardtime_ignore_buffer_patterns = ["man"]
let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
let g:list_of_insert_keys = []

" goyo config
function! s:goyo_enter()
    set nonu nornu
    HardTimeOff
    "Limelight
endfunction

function! s:goyo_leave()
    if &ft == 'man' | q | endif
    set nu rnu
    HardTimeOn
    "Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" limelight config
let g:limelight_conceal_ctermfg = 4
let g:limelight_conceal_guifg = '#80a0ff'

" cpp enhanced highlight conifg
let g:cpp_experimental_template_highlight = 1
let g:cpp_class_scope_highlight = 1

" interestingwords config
let g:interestingWordsTermColors = ['211', '81', '48', '141']

" SimpylFold config
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" FZF and Skim config
autocmd! FileType fzf,skim
autocmd  FileType fzf,skim set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 "showmode ruler
"let g:fzf_nvim_statusline = 0 " disable statusline overwriting

command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --colors "path:fg:green" --colors "path:style:nobold" --colors "line:fg:yellow" --colors "line:style:nobold" --colors "match:fg:black" --colors "match:bg:yellow" --column --line-number --no-heading --color=always --colors "match:style:nobold" --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir F
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! B :Buffers
command! W :Windows
command! T :Tags
command! S :GitFiles?
command! M :Marks
command! L :Lines

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
