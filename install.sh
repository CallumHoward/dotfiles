#!/bin/bash

declare -a files=(
    '.config'
    '.gitconfig'
    '.tmux.conf'

    '.vim'
    '.vimrc'
    #'.gvimrc'
    #'.xvimrc'

    '.zshrc'
    #'.oh-my-zsh'
    '.shell_aliases'
    '.shell_exports'
    '.zsh_keybindings'
    '.zsh_styles'
    '.zsh_functions'
)

if [ "${PWD##*/}" != "dotfiles" ]; then
    echo "$0: run this script from inside the dotfiles directory"
    exit
fi

for i in "${files[@]}"; do
    if [ "`ls ~/$i 2> /dev/null`" == "" ]; then
        ln -sv "`pwd`/$i" ~/"$i"
    fi
done

echo -n "Install oh-my-zsh [Y/n]? "
read answer
if echo "$answer" | grep -viq "^n" ;then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    rm -rf ~/.oh-my-zsh/custom
    ln -fs `pwd`/.oh-my-zsh/custom ~/.oh-my-zsh/custom
fi
