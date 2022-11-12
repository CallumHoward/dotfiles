" mappings.vim
" Vim mappings configuration
" Callum Howard

" add word under cursor to search pattern
nnoremap <leader>* /<C-R>/\\|\<<C-R><C-W>\><CR><C-O>
nnoremap <leader>? /<C-R>/\\|

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

" nmap cst #V%o\sa<BS>

" dot command works on ranges
xnoremap . :normal .<CR>

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

" unimpaired move line mappings
function! s:ExecMove(cmd) abort
  let old_fdm = &foldmethod
  if old_fdm !=# 'manual'
    let &foldmethod = 'manual'
  endif
  normal! m`
  silent! exe a:cmd
  norm! ``
  if old_fdm !=# 'manual'
    let &foldmethod = old_fdm
  endif
endfunction

function! s:Move(cmd, count, map) abort
  call s:ExecMove('move'.a:cmd.a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-".a:map.")", a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  call s:ExecMove("'<,'>move'<--".a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-selection-up)", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  call s:ExecMove("'<,'>move'>+".a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-selection-down)", a:count)
endfunction

nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>
nnoremap <silent><M-k> <Plug>unimpairedMoveUp\|==
nnoremap <silent><M-j> <Plug>unimpairedMoveDown\|==
xnoremap <silent><M-k> <Plug>unimpairedMoveSelectionUp\|gv=gv
xnoremap <silent><M-j> <Plug>unimpairedMoveSelectionDown\|gv=gv
inoremap <silent><M-k> <Esc>:m-2<CR>==gi
inoremap <silent><M-j> <Esc>:m+1<CR>==gi

" restrict search to comment
"nnoremap <leader>c ?\v(//|#).*\zs
"nnoremap <leader>c ?//.*\zs
"xnoremap <leader>c ?//.*\zs

" convert search pattern to match whole word only
nnoremap <silent> <expr> <leader>w @/ =~# '^\\<.*\\>$'
            \ ? ':let @/=substitute(@/, "\\\\<\\\|\\\\V\\\|\\\\>", "", "g")<CR>:echo "/".@/<CR>'
            \ : ':let @/="\\<<C-R>/\\>"<CR>:echo "/".@/<CR>'
" strip whole word patterns when pasting search register
inoremap <silent><C-R>/ <C-O>:let @m=substitute(@/, "\\\\<\\\|\\\\V\\\|\\\\>", "", "g")<CR><C-R>m

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

cabbrev cd. <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'lcd %:p:h\|pwd' : 'cd.')<CR>
command! Cdg exec 'cd' fnameescape(fnamemodify(finddir('.git', escape(expand('%:p:h'), ' ') . ';'), ':h'))
cabbrev cdg <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Cdg' : 'cdg')<CR>

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

" don't close split when deleting a buffer
command Bd BufferClose
cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>
cabbrev Bd! <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'bd!' : 'Bd!')<CR>
nnoremap <silent> <Leader><C-W>c <cmd>BufferClose<CR>
nnoremap <silent> <Leader><C-W>o <cmd>BufferCloseAllButCurrent<CR>

" Prettier
" command! P :!prettier --write "%"
command! P :FormatWrite

" Lcov
command! C :set fdm=manual | LcovVisible coverage/lcov.info
