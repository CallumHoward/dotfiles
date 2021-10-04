setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal formatexpr=clang_format#replace(v:lnum,v:lnum+v:count-1)
let $CFLAGS = '-Wall -Wextra -pedantic -Wno-unused-parameter -std=c99 -g'

set path+=/usr/local/opt/llvm/include/c++/v1

" jump to #includes and add a new include prepolulated with word under cursor
nnoremap <leader>i m`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include <<C-R>1><Esc>hvi><C-G>
nnoremap <leader>I m`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include "<C-R>1.h"<Esc>hvi"<C-G>

" convert c-style prototypes to functions
nnoremap <leader>; :keeppatterns %s/;$/ {\r\r}\r<CR>:noh<CR><C-O>
xnoremap <leader>; :s/;$/ {\r\r}\r<CR>:noh<CR><C-O>

" add function prototype for function under cursor
nnoremap <silent> <leader>p yy:keeppatterns ?^#include\><CR>jp:keeppatterns s/\s*{$/;<CR>:silent! keeppatterns s/(\zs\ze);/void<CR>:noh<CR><C-O>
xnoremap <silent> <leader>p y:keeppatterns ?^#include\><CR>jp:keeppatterns s/\s*{$/;<CR>:silent! keeppatterns s/(\zs\ze);/void<CR>:noh<CR><C-O>

