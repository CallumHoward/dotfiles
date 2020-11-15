setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=//\ %s

nnoremap <leader>jl yiwoconsole.log("LOG <C-R>": ", <C-R>");<Esc>
xnoremap <leader>jl yoconsole.log("LOG: ", <C-R>");<Esc>
