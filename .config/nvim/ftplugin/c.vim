setlocal formatexpr=clang_format#replace(v:lnum,v:lnum+v:count-1)
let $CFLAGS = '-Wall -Wextra -pedantic -Wno-unused-parameter -std=c99 -g'

set path+=/usr/local/opt/llvm/include/c++/v1

" jump to #includes and add a new include prepolulated with word under cursor
nnoremap <leader>i m`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include <<C-R>1><Esc>hvi><C-G>
nnoremap <leader>I m`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include "<C-R>1.h"<Esc>hvi"<C-G>
