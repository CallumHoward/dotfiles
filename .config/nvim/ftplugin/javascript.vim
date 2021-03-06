setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=//\ %s

nnoremap <leader>jl yiwoconsole.log("LOG <C-R>": ", <C-R>");<Esc>
xnoremap <leader>jl yoconsole.log("LOG: ", <C-R>");<Esc>
nnoremap <leader>j1 oconsole.log("LOG Stage 1: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:
nnoremap <leader>j2 oconsole.log("LOG Stage 2: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:
nnoremap <leader>j3 oconsole.log("LOG Stage 3: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:
nnoremap <leader>j4 oconsole.log("LOG Stage 4: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:
nnoremap <leader>j5 oconsole.log("LOG Stage 5: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:
nnoremap <leader>j6 oconsole.log("LOG Stage 6: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:
nnoremap <leader>j7 oconsole.log("LOG Stage 7: <C-R>=expand('%:t')<CR>:<C-R>=line('.')<CR>");<Esc>0t:

nnoremap <leader>jo 0/it\ze(/e<CR>a.only<Esc>
nnoremap <leader>jO :s/\.only//<CR>
nnoremap <leader>js 0/it\ze(/e<CR>a.skip<Esc>
nnoremap <leader>jS :s/\.skip//<CR>
