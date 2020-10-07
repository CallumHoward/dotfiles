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
    call dein#add('wellle/tmux-complete.vim')                  " tmux window completion source
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
    call dein#add('Shougo/neco-syntax')
    call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

    " feature plugins
    call dein#add('neomake/neomake')
    call dein#add('kshenoy/vim-signature')              " marks in signs column
    call dein#add('liuchengxu/vista.vim',                {'on_cmd': 'Vista'})               " language server aware tags
    call dein#add('majutsushi/tagbar',                  {'on_cmd': 'TagbarToggle'})
    call dein#add('valloric/MatchTagAlways') ",            {'on_ft': ['html', 'xml', 'jsx', 'tsx', 'javascriptreact']})
    call dein#add('alvan/vim-closetag') ",                 {'on_ft': ['html', 'xml', 'jsx', 'tsx', 'javascriptreact']})
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
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('joeytwiddle/sexy_scroller.vim')
    call dein#add('iamcco/markdown-preview.nvim', {
                \ 'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
                \ 'build': 'sh -c "cd app & yarn install"' })
    call dein#add('Yggdroot/indentLine')
    call dein#add('lukas-reineke/indent-blankline.nvim')
    call dein#add('APZelos/blamer.nvim')
    call dein#add('rhysd/git-messenger.vim', {
                \   'lazy' : 1,
                \   'on_cmd' : 'GitMessenger',
                \   'on_map' : '<Plug>(git-messenger)',
                \ })

    " wrap external tools
    call dein#add('ludovicchabant/vim-gutentags',       {'on_ft': ['c', 'cpp', 'python']})
    call dein#add('lambdalisue/gina.vim',               {'on_cmd': 'Gina'})
    call dein#add('rhysd/vim-clang-format',             {'on_ft': ['c', 'cpp', 'arduino']})
    "call dein#add('alepez/vim-llvmcov',                 {'on_ft': ['c', 'cpp']})
    "call dein#add('lotabout/skim',                      {'build': './install --all', 'merged': 0})
    "call dein#add('CallumHoward/skim.vim',              {'depends': 'skim'})
    call dein#add('junegunn/fzf',                       { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim',                   { 'depends': 'fzf' })
    call dein#add('coreyja/fzf.devicon.vim',            { 'depends': 'fzf' })
    call dein#add('sakhnik/nvim-gdb')                   " gdb and lldb wrapper
    call dein#add('francoiscabrol/ranger.vim')          " ranger as netrw replacement
    call dein#add('CallumHoward/vim-tbone')             " send text to tmux pane
    call dein#add('CoatiSoftware/vim-sourcetrail',      {'on_cmd': 'SourcetrailStartServer'})
    "call dein#add('yamahigashi/sendtomaya.vim')
    call dein#add('romainl/vim-devdocs',                {'on_cmd': 'DD'})
    call dein#add('rizzatti/dash.vim')
    call dein#add('wfleming/vim-codeclimate')

    " keybindings
    call dein#add('tpope/vim-surround.git',             {'on_event': s:ces})
    call dein#add('tpope/vim-repeat',                   {'on_event': s:ces})
    call dein#add('tpope/vim-commentary')               " for easy commenting
    call dein#add('tpope/vim-rsi', {'on_event': s:ces}) " enable readline key mappings
    call dein#add('takac/vim-hardtime')                 " disable rapid hjkl repeat
    call dein#add('ton/vim-bufsurf')

    " colorschemes
    call dein#add('~/neodark')
    call dein#add('cocopon/iceberg.vim')
    call dein#add('mhartington/oceanic-next')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('christianchiarulli/onedark.vim')

    " syntax plugins
    call dein#add('rust-lang/rust.vim')
    call dein#add('sophacles/vim-processing',           {'on_ft': 'processing'})
    call dein#add('wavded/vim-stylus')                  " can't be lazy
    call dein#add('neovimhaskell/haskell-vim')          " can't be lazy
    call dein#add('tikhomirov/vim-glsl')
    call dein#add('yuezk/vim-js')                       " can't be lazy
    call dein#add('maxmellon/vim-jsx-pretty')           " can't be lazy
    call dein#add('HerringtonDarkholme/yats.vim')       " can't be lazy
    call dein#add('nguquen/vim-styled-components')
    call dein#add('vim-scripts/SyntaxAttr.vim')
    "call dein#add('arakashic/chromatica.nvim')          " can't be lazy
    "call dein#add('octol/vim-cpp-enhanced-highlight')   " can't be lazy
    call dein#add('mustache/vim-mustache-handlebars')
    call dein#add('masukomi/vim-markdown-folding')
    call dein#add('kchmck/vim-coffee-script')
    "call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0 })

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
" let g:neosnippet#expand_word_boundary = 1
" imap <expr><TAB> neosnippet#expandable()
"             \ ? "\<Plug>(neosnippet_expand)" : pumvisible()
"             \ ? "\<C-n>" : neosnippet#jumpable()
"             \ ? "\<Plug>(neosnippet_jump)" : <SID>check_back_space()
"             \ ? "\<TAB>" : coc#refresh()
" smap <expr><TAB> neosnippet#expandable_or_jumpable()
"             \ ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" xmap <TAB> <Plug>(neosnippet_expand_target)

inoremap <silent><expr> <TAB> pumvisible()
            \ ? coc#_select_confirm() : coc#expandableOrJumpable()
            \ ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : <SID>check_back_space()
            \ ? "\<TAB>" : coc#refresh()
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" conceal neosnippet markers
set conceallevel=2
set concealcursor=niv

" allow automatic function signature expansion
let g:neosnippet#enable_completed_snippet=1
let g:neosnippet#enable_optional_arguments=0

" jsx and typescript config
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx foldmethod=manual

" vim-closetag config
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx,*.md"
let g:closetag_xhtml_filetypes = 'xml,xhtml,jsx,javascript.jsx,javascript.tsx,typescript.tsx,javascriptreact'
let g:closetag_emptyTags_caseSensitive = 1
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1

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
hi GitGutterAdd ctermfg=2 ctermbg=none
hi GitGutterChange ctermfg=3 ctermbg=none
hi GitGutterDelete ctermfg=1 cterm=bold ctermbg=none
hi GitGutterChangeDelete ctermfg=1 ctermbg=none
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_removed_first_line =  '˙'
let g:gitgutter_sign_modified_removed = '│'
"let g:gitgutter_override_sign_column_highlight = 0  " apparently now obselete
"let g:gitgutter_diff_args = '-w'
"let g:gitgutter_map_keys = 0

" signature config
let g:SignatureMap = {'Leader' : 'm'}   " disable extra mappings
let g:SignatureMarkTextHLDynamic = 1    " keep gitgutter highlight color
let g:SignatureForceMarkPlacement = 1   " use :delm x to delete mark x

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

command! SynAttr :call SyntaxAttr()

" Code climate config
nmap <silent> <leader>cC :CodeClimateAnalyzeOpenFiles<CR>

" CoC config
let g:coc_node_path = '/usr/local/bin/node'
set hidden "if hidden is not set, TextEdit might fail.
" mapping to jump to tag under cursor

nmap <silent> gr #<Plug>(coc-references)
nnoremap <silent> gd <C-]>
nmap <silent> <C-]> :silent! TagImposterAnticipateJump<CR><Plug>(coc-definition)
nmap <silent> <C-W>] :split<CR>:silent! TagImposterAnticipateJump<CR><Plug>(coc-definition)
nmap <silent> <C-W><C-]> :split<CR>:silent! TagImposterAnticipateJump<CR><Plug>(coc-definition)

nmap <silent> <leader>cy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-rename)
vmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>ca  <Plug>(coc-codeaction-line)
nmap <leader>cA  <Plug>(coc-codeaction)
nmap <leader>cx  <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>cl :<C-u>CocList<CR>
nnoremap <silent> <leader>cp :<C-u>CocListResume<CR>
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<CR>
nnoremap <silent> <leader>cj :<C-u>CocNext<CR>
nnoremap <silent> <leader>ck :<C-u>CocPrev<CR>
nnoremap <silent> <leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics --normal<CR>
nnoremap <leader>c?  :nmap <leader>c<CR>
nnoremap <leader>cc :CocCommand<CR>

" Use `[C` and `]C` to navigate diagnostics
nmap <silent> [C <Plug>(coc-diagnostic-prev)
nmap <silent> ]C <Plug>(coc-diagnostic-next)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 CFormat :call CocAction('format')
command! -nargs=? CFold :call CocAction('fold', <f-args>) " args: comment, imports or region
command! -nargs=0 CDiag :call CocAction('diagnosticPreview')

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
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FocusGained * silent CocCommand git.refresh
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
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

nnoremap <leader><C-i> :Vista!!<CR>

" vista config
"let g:vista#renderer#enable_icon=0
let g:vista_icon_indent = ["└ ", "│ "]
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 45
let g:vista#renderer#icons = {
      \ 'field': '',
      \ 'fields': '',
      \ 'enumerator': 'הּ',
      \ 'enum': 'הּ',
      \ 'variable': '𝑣',
      \}

" poppy config
if dein#is_sourced('poppy.vim')
    au CursorMoved,CursorMovedI * call PoppyInit()
    let g:poppyhigh = ['Ignore']
    let g:poppy_point_enable = 1
endif

" markdown preview config
let g:mkdp_markdown_css = '~/dotfiles/github-markdown-css/github-markdown.css'

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

" blamer config
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_relative_time = 1
let g:blamer_template = '<author> <author-time> • <summary>'  " hardcoded time to inlcude space

" goyo config
function! s:goyo_enter()
    set nonu nornu
    Tmux set -g status off
    "HardTimeOff
    "Limelight
endfunction

function! s:goyo_leave()
    if &ft == 'man' | q | endif
    set nu rnu
    Tmux set -g status on
    "HardTimeOn
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
let g:interestingWordsRandomiseColors = 1

" SimpylFold config
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" FZF and Skim config
autocmd! FileType fzf,skim
autocmd  FileType fzf,skim set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 "showmode ruler
"let g:fzf_nvim_statusline = 0 " disable statusline overwriting

" javascript config
autocmd bufnewfile,bufread *.tsx set filetype=typescript.tsx
autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx

command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --colors "path:fg:green" --colors "path:style:nobold" --colors "line:fg:yellow" --colors "line:style:nobold" --colors "match:fg:black" --colors "match:bg:yellow" --column --line-number --no-heading --color=always --colors "match:style:nobold" --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

" Files + devicons
function! Fzf_files_with_dev_icons(command, full)
    let l:fzf_files_options = '--preview "scope {2..} 2>/dev/null || cat {2..} 2>/dev/null || CLICOLOR_FORCE=1 ls -G {2..} 2>/dev/null"'
    function! s:edit_devicon_prepended_file(item)
        let l:file_path = a:item[4:-1]
        execute 'silent e' l:file_path
    endfunction
    if a:full == '1'
        call fzf#run({
                    \ 'source': a:command.' | devicon-lookup',
                    \ 'sink':   function('s:edit_devicon_prepended_file'),
                    \ 'options': '-m ' . l:fzf_files_options,
                    \ 'window': 'enew' })
    else
        call fzf#run({
                    \ 'source': a:command.' | devicon-lookup',
                    \ 'sink':   function('s:edit_devicon_prepended_file'),
                    \ 'options': '-m ' . l:fzf_files_options,
                    \ 'down': '40%' })
    endif
endfunction

function! Fzf_git_diff_files_with_dev_icons(full)
    let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; scope {3..} 2>/dev/null || [[ $? -eq 1 ]] && cat {3..} 2>/dev/null)\""'
    function! s:edit_devicon_prepended_file_diff(item)
        echom a:item
        let l:file_path = a:item[7:-1]
        echom l:file_path
        let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")
        execute 'silent e' l:file_path
        execute l:first_diff_line_number
    endfunction
    if a:full
        call fzf#run({
                    \ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup',
                    \ 'sink':   function('s:edit_devicon_prepended_file_diff'),
                    \ 'options': '-m ' . l:fzf_files_options,
                    \ 'window': 'enew' })
    else
        call fzf#run({
                    \ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup',
                    \ 'sink':   function('s:edit_devicon_prepended_file_diff'),
                    \ 'options': '-m ' . l:fzf_files_options,
                    \ 'down': '40%' })
    endif
endfunction

function! Fzf_git_diff_merge_base_with_dev_icons(full)
    let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always master...HEAD -- {2..} | sed 1,4d; scope {2..} 2>/dev/null || [[ $? -eq 1 ]] && cat {2..} 2>/dev/null)\""'
    function! s:edit_devicon_prepended_file(item)
        let l:file_path = a:item[4:-1]
        execute 'silent e' l:file_path
    endfunction
    if a:full
        call fzf#run({
                    \ 'source': 'git -c color.status=always diff master...HEAD --name-only | sed \$d | devicon-lookup',
                    \ 'sink':   function('s:edit_devicon_prepended_file'),
                    \ 'options': '-m ' . l:fzf_files_options,
                    \ 'window': 'enew' })
    else
        call fzf#run({
                    \ 'source': 'git -c color.status=always diff master...HEAD --name-only | sed \$d | devicon-lookup',
                    \ 'sink':   function('s:edit_devicon_prepended_file'),
                    \ 'options': '-m ' . l:fzf_files_options,
                    \ 'down': '40%' })
    endif
endfunction

 " Open fzf Files " Open fzf Files
command! F :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND, '0')
command! F1 :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND, '1')
command! S :call Fzf_git_diff_files_with_dev_icons('0')
command! S1 :call Fzf_git_diff_files_with_dev_icons('1')
command! GF :call Fzf_files_with_dev_icons("git ls-files \| uniq", '0')
command! MB :call Fzf_git_diff_merge_base_with_dev_icons('0')
command! MB1 :call Fzf_git_diff_merge_base_with_dev_icons('1')

command! B :Buffers
command! W :Windows
command! T :Tags
"command! S :GitFiles?
command! M :Marks
command! L :Lines
command! H :History

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Tabline config
set tabline=%!MyTabLine()
function MyTabLine()
    let s = '' " complete tabline goes here
    " loop through each tab page
    for t in range(tabpagenr('$'))
        " select the highlighting for the buffer names
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " empty space
        let s .= ' '
        " set the tab page number (for mouse clicks)
        let s .= '%' . (t + 1) . 'T'
        " get buffer names and statuses
        let n = ''  " temp string for buffer names while we loop and check buftype
        let buflist = tabpagebuflist(t + 1)
        let bufcounter = 0  " counter to avoid last seperator
        " loop through each buffer in a tab
        for bufnr in buflist
            let winnr = tabpagewinnr(t + 1)
            let ismainpage = bufcounter == winnr - 1
            if exists('*WebDevIconsGetFileTypeSymbol')  " support for vim-devicons
                let n .= WebDevIconsGetFileTypeSymbol(fnamemodify(bufname(bufnr), ':t'))
                if ismainpage
                    let n .= ' '
                endif
            else
                let n .= '#'
                if ismainpage
                    let n .= ' '
                endif
            endif
            if !ismainpage
                " do nothing
            elseif bufname(bufnr) == ''
                let n .= '[No Name]'
            else
                let n .= fnamemodify(bufname(bufnr), ':t')
            endif
            " check and ++ tab's &modified count
            if getbufvar(bufnr, "&modified")
                let n .= ' +'
            endif
            " no final ' ' added...formatting looks better done later
            if bufcounter < len(buflist) - 1
                let n .= ' | '
            endif
            let bufcounter += 1
        endfor
        " add buffer names
        let s .= n
        " switch to no underlining and add final space to buffer list
        let s .= ' %#TabLineFill# '
        "let s .= ' '
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    "if tabpagenr('$') > 1
    "  let s .= '%=%#TabLine#%999XX'
    "endif
    return s
endfunction

set tabline=%!MyTabLine()

" vim-jsx-pretty config
let g:vim_jsx_pretty_highlight_close_tag = 0
let g:vim_jsx_pretty_colorful_config = 1

" indent guides config
let g:indentLine_char = '│'
let g:indentLine_color_term = 232
let g:indent_blankline_extra_indent_level = -1
let g:indentLine_fileType = ['c', 'cpp', 'typescript.tsx', 'javascript.jsx', 'javascript', 'html', 'typescript', 'java', 'arduino', 'processing', 'go', 'html.handlebars', 'scss']

" treesitter
"luafile ~/.config/nvim/treesitter.lua
