#!/bin/bash

declare -a files=(
    '.config'
    '.gitconfig'
    '.tmux.conf'

    '.vim'
    '.vimrc'
    #'.gvimrc'
    #'.xvimrc'
    '.ideavimrc'

    '.zshrc'
    #'.oh-my-zsh'
    '.shell_aliases'
    '.shell_exports'
    '.zsh_aliases'
    '.zsh_keybindings'
    '.zsh_styles'
    '.zsh_functions'
)

if [ "${PWD##*/}" != "dotfiles" ]; then
    echo "$0: run this script from inside the dotfiles directory"
    exit
fi

if [ -x $(which apt-get) ]; then
    echo -n "Install: zsh ssh git tmux curl wget vim ranger cmake htop [Y/n]? "
    read answer
    if echo "$answer" | grep -viq "^n" ; then
        sudo apt-get install zsh ssh git tmux curl wget vim ranger cmake htop
    fi
fi

echo -n "Install oh-my-zsh [Y/n]? "
read answer
if echo "$answer" | grep -viq "^n" ; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    rm -rf ~/.oh-my-zsh/custom
    ln -fs `pwd`/.oh-my-zsh/custom ~/.oh-my-zsh/custom
    rm ~/.zshrc
fi

for i in "${files[@]}"; do
    if [ "`ls ~/$i 2> /dev/null`" == "" ]; then
        ln -sv "`pwd`/$i" ~/"$i"
    fi
done

