" mappings.vim
" Vim mappings configuration
" Callum Howard

nnoremap ' `
nnoremap ` '

" toggle relative line numbers
function! ToggleLineNumber()
  if g:numbertoggle != 1
    let g:numbertoggle = 1
  else
    let g:numbertoggle = 0
  endif
  setl rnu!
endfunction

nnoremap <silent><C-Space> :call ToggleLineNumber()<CR>

" select last pasted
nnoremap gV `[v`]

" add word under cursor to search pattern
nnoremap <leader>* /<C-R>/\\|\<<C-R><C-W>\><CR><C-O>
nnoremap <leader>? /<C-R>/\\|

" go to alternate file
nnoremap <leader>e :e %<.
nnoremap <leader>E :vs %<.

" toggle diff
function! ToggleDiff()
    if &diff
        windo diffoff
    else
        windo diffthis
    endif
    wincmd w
endfunction

nnoremap <leader>d :call ToggleDiff()<CR>

let g:tbone_write_pane='bottom-right'
nnoremap <leader>t V:Twrite<CR>
xnoremap <leader>t :Twrite<CR>
nnoremap <leader><CR> V:Twrite<CR>:Tmux send-keys -t bottom Enter<CR>
xnoremap <CR> :Twrite!<CR>:Tmux send-keys -t bottom Enter<CR>

nnoremap <silent> g/ /^[<=>]\{7}<CR>

nnoremap <silent><C-W>c :ScrollViewDisable<CR><C-W>c:ScrollViewEnable<CR>

nmap cst #V%o\sa<BS>

" move tabs
nnoremap <silent>g> :tabm +1<CR>
nnoremap <silent>g< :tabm -1<CR>

" dot command works on ranges
xnoremap . :normal .<CR>

" wrapped line movement mappings (adds larger jumps to jumplist)
nnoremap <expr> j v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
xnoremap <expr> j v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
xnoremap <expr> k v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" incremental commandline history search
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

" prevent jump after searching word under cursor with # and *, clear with Escape
nnoremap <silent> # :let save_cursor=getcurpos()\|let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>w?<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
"nnoremap <silent> * :let save_cursor=getcurpos()\|let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> g# :let save_cursor=getcurpos()\|let @/ = expand('<cword>')\|set hlsearch<CR>w?<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> g* :let save_cursor=getcurpos()\|let @/ = expand('<cword>')\|set hlsearch<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> <Esc> :noh<CR><Esc>
nnoremap <silent> <expr> <2-LeftMouse> foldclosed(line('.')) == -1 ? ":let save_cursor=getcurpos()\|let @/ = '\\<'.expand('<cword>').'\\>'\|set hlsearch<CR>w?<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR><2-LeftMouse>" : 'zo'

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>:setl hlsearch<CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>:setl hlsearch<CR>

" unimpaired quickfix mappings
nnoremap <silent> <leader>q :cw<CR><C-W>J
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" unimpaired location list mappings
nnoremap <silent> <leader>l :lw<CR>
nnoremap <silent> [l :lprevious<CR>zmzv
nnoremap <silent> ]l :lnext<CR>zmzv
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" unimpaired buffer mappings
nnoremap <silent> [b :BufferPrevious<CR>
nnoremap <silent> ]b :BufferNext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" unimpaired tab mappings
nnoremap <silent>]t gt
nnoremap <silent>[t gT
nnoremap <silent>[T :tabfirst<CR>
nnoremap <silent>]T :tablast<CR>

" tab navigation mappings
nnoremap <silent><C-W>1 :tabn 1<CR>
nnoremap <silent><C-W>2 :tabn 2<CR>
nnoremap <silent><C-W>3 :tabn 3<CR>
nnoremap <silent><C-W>4 :tabn 4<CR>
nnoremap <silent><C-W>5 :tabn 5<CR>
nnoremap <silent><C-W>6 :tabn 6<CR>
nnoremap <silent><C-W>7 :tabn 7<CR>
nnoremap <silent><C-W>8 :tabn 8<CR>
nnoremap <silent><C-W>0 :tabfirst<CR>
nnoremap <silent><C-W>9 :tablast<CR>

" open new vertical split mappings
nnoremap <silent><C-W><C-F> <C-W><C-V>gF
nmap <silent><C-W><C-]> <C-W><C-V><C-]>

" move tabs
" nnoremap <silent>g> :tabm +1<CR>
" nnoremap <silent>g< :tabm -1<CR>
nnoremap <silent>g> :BufferMoveNext<CR>
nnoremap <silent>g< :BufferMovePrevious<CR>

" accordion expand traversal of folds
nnoremap <silent> z] :<C-u>silent! normal! zc<CR>zjzozz
nnoremap <silent> z[ :<C-u>silent! normal! zc<CR>zkzo[zzz
nnoremap <silent> zV :<C-u>silent! normal! zM<CR>zv
nnoremap <silent> <Space> za

" resync folds
nnoremap <silent> <leader>f :set foldmethod=manual<CR>zE:call CocAction('fold')<CR>zvzz
nnoremap <silent> <C-l> <C-l>:syntax sync fromstart<CR>

" quickly set foldlevel
nnoremap <leader>1 :set foldnestmax=1<CR>
nnoremap <leader>2 :set foldnestmax=2<CR>
nnoremap <leader>3 :set foldnestmax=3<CR>
nnoremap <leader>4 :set foldnestmax=4<CR>
nnoremap <leader>5 :set foldnestmax=5<CR>

" insert closing curly brace
inoremap <expr> {<Enter> <SID>CloseBracket()

" readline-like delete to end of line
imap <C-k> <C-o>D

" remove trailing whitespace
nnoremap <silent> <leader><Space> :keeppatterns %s/\s\+$//e<CR><C-O>
xnoremap <silent> <leader><Space> :keeppatterns s/\s\+$//e<CR><C-O>

" global substitution on last used search pattern
nnoremap <leader>s :%s///g<Left><Left>
xnoremap <leader>s :s///g<Left><Left>
nnoremap <leader>S :%Subvert/<C-R>///g<Left><Left>
xnoremap <leader>S :Subvert/<C-R>///g<Left><Left>

" global mappings
nnoremap <leader>gn :g//norm 
nnoremap <leader>gd :g//d<CR>
xnoremap <leader>gn :g//norm 
xnoremap <leader>gd :g//d<CR>

" restrict search to comment
"nnoremap <leader>c ?\v(//|#).*\zs
"nnoremap <leader>c ?//.*\zs
"xnoremap <leader>c ?//.*\zs

" convert search pattern to match whole word only
nnoremap <silent> <expr> <leader>w @/ =~# '^\\<.*\\>$'
            \ ? ':let @/=substitute(@/, "\\\\<\\\|\\\\>", "", "g")<CR>:echo "/".@/<CR>'
            \ : ':let @/="\\<<C-R>/\\>"<CR>:echo "/".@/<CR>'

" save temp session
nnoremap <leader>]] :ScrollViewDisable <bar> mks! ~/sess/temp_session.vim <bar> ScrollViewEnable<CR>
nnoremap <leader>[[ :source ~/sess/temp_session.vim<CR>

augroup TerminalConfig
    au!
    autocmd TermOpen * setlocal nonumber norelativenumber
let g:previous_window = -1
function SmartInsert()
  if &buftype == 'terminal'
    if g:previous_window != winnr()
      startinsert
    endif
    let g:previous_window = winnr()
  else
    let g:previous_window = -1
  endif
endfunction

au BufEnter * call SmartInsert()
augroup END

tnoremap <C-W><C-W> <C-\><C-N><C-W><C-W>
tnoremap <C-W><C-H> <C-\><C-N><C-W><C-H>
tnoremap <C-W><C-J> <C-\><C-N><C-W><C-J>
tnoremap <C-W><C-K> <C-\><C-N><C-W><C-K>
tnoremap <C-W><C-L> <C-\><C-N><C-W><C-L>

nnoremap <silent> <Leader>\ :CocCommand explorer --toggle --sources=buffer+,file+<CR>

"nnoremap <silent> <Leader>\ :call ToggleNetrw()<CR>
nnoremap <silent> <Leader>\ :CocCommand explorer --sources buffer+,file+ --width=45<CR>
cabbrev cd. <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'lcd %:p:h\|pwd' : 'cd.')<CR>
command! Cdg exec 'cd' fnameescape(fnamemodify(finddir('.git', escape(expand('%:p:h'), ' ') . ';'), ':h'))
cabbrev cdg <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Cdg' : 'cdg')<CR>

" grep for word under cursor
nmap <silent> <Leader># #:sil! gr! "\b<C-R><C-W>\b"<CR>:cope<CR><C-W>J:sil redr!<CR>
xmap <silent> <Leader># y/<C-R>"<CR>:sil! gr! '<C-R>"'<CR>:cope<CR><C-W>J:sil redr!<CR>
"nmap <silent> <Leader>* #ccl<CR>:sil! gr! "\b<C-R><C-W>\b"<CR>:cope<CR><C-W>J:sil redr!<CR>

" open quickfix window for the last search
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:cope<CR><C-W>J

" fuzzy command mappings
cabbrev vf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sf' : 'vf')<CR>
cabbrev vsf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sf' : 'vsf')<CR>
cabbrev ef <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'fin' : 'ef')<CR>

" local markings mapping
nnoremap <leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:norm `
nnoremap <leader>M :marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>:norm `

" visual at
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" wrap git grep
function! Ggrep(arg)
    let s:temp=&grepprg
    setlocal grepprg=git\ grep\ --ignore-case\ --no-color\ -n\ $*
    silent execute ':grep '.a:arg
    setlocal grepprg=git\ --no-pager\ submodule\ --quiet\ foreach\ 'git\ grep\ --full-name\ -n\ --ignore-case\ --no-color\ $*\ ;true'
    silent execute ':grepadd '.a:arg
    silent cwin
    redraw!
    setlocal grepprg=s:temp
endfunction

command! -nargs=1 -complete=buffer Gg call Ggrep(<q-args>)|let @/="<args>"|set hls
cabbrev gg <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gg' : 'gg')<CR>

" use Ag/Rg for grep if available
if executable('rg') | set gp=rg\ -S\ --vimgrep\ --no-heading gfm=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m|endif
com! -nargs=+ -complete=file -bar Rg sil! gr! <args>|botright cw|redr!|let @/="<args>"|set hls
cabbrev rg <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Rg' : 'rg')<CR>

" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
    return filter(map(copy(v:oldfiles), 'fnamemodify(v:val, ":~:.")'), 'v:val =~ a:ArgLead')
endfunction

" browse most recently opened files with :O or :o
com! -nargs=? -complete=customlist,<sid>MRUComplete O if empty("<args>")|bro o|else|e <args>|endif
cabbrev o <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'O' : 'o')<CR>

" map arrow keys for commandline Pmenu
if &wildoptions =~# "pum"
  cnoremap <expr> <up> pumvisible() ? '<left>' : '<up>'
  cnoremap <expr> <down> pumvisible() ? '<right>' : '<down>'
endif

function! s:CloseBracket()
    let line = getline('.')
    if &ft =~# 'c\|cpp\|rust\|go\|python' && line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif &ft =~# 'javascript\|react\|javascriptreact\|typescript\|typescriptreact' && line =~# '^\s*\(var\|const\|let\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction

" don't close split when deleting a buffer
command Bd bp\|bd #

