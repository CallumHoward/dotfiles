#!/bin/bash

declare -a files=(
    '.config'
    '.gitconfig'
    '.tmux.conf'

    '.vim'
    '.vimrc'
    #'.gvimrc'
    #'.xvimrc'

    #'.zshrc'
    #'.oh-my-zsh'
    '.shell_aliases'
    '.shell_exports'
    #'.zsh_keybindings'
    #'.zsh_styles'
    #'.zsh_functions'
)

if [ "${PWD##*/}" == "dotfiles" ]; then
    for i in "${files[@]}"; do
        if [ "`ls ~/$i 2> /dev/null`" == "" ]; then
            ln -sv "`pwd`/$i" ~/"$i"
        fi
    done
else
    echo "$0: run this script from inside the dotfiles directory"
fi
