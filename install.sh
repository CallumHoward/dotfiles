#!/bin/bash

declare -a files=(
    '.config'
    '.gitconfig'
    #'.gvimrc'
    #'.oh-my-zsh'
    '.tmux.conf'
    '.vim'
    '.vimrc'
    #'.xvimrc'
    #'.zshrc'
)

if [ "${PWD##*/}" == "dotfiles" ]; then
    for i in "${files[@]}"; do
        #if `ls ~/$i`; then mv ~/$i ~/$i.old; fi
        ln -sv "`pwd`/$i" ~/"$i"
    done
else
    echo "$0: run this script from inside the dotfiles directory"
fi
