" init.vim
" Neovim configuration
" Callum Howard

if filereadable(expand('~/.config/nvim/plugins.vim'))
    source ~/.config/nvim/plugins.vim
endif

if filereadable(expand('~/.config/nvim/base.vim'))
    source ~/.config/nvim/base.vim
endif

if filereadable(expand('~/.config/nvim/mappings.vim'))
    source ~/.config/nvim/mappings.vim
endif

if filereadable(expand('~/.config/nvim/local.vim'))
    source ~/.config/nvim/local.vim
endif
