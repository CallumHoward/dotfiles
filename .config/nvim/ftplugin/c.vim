setlocal formatexpr=clang_format#replace(v:lnum,v:lnum+v:count-1)
let $CFLAGS = '-Wall -Wextra -pedantic -Wno-unused-parameter -std=c99 -g'

set path+=/usr/local/opt/llvm/include/c++/v1
