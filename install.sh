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

if [ -x "$(which apt-get)" ]; then
    echo -n "Install: zsh ssh git tmux curl wget vim ranger cmake htop [Y/n]? "
    read answer
    if echo "$answer" | grep -viq "^n" ; then
        sudo apt-get install zsh ssh git tmux curl wget vim ranger cmake htop
    fi
fi
echo "Finished installing packages"

echo -n "Install oh-my-zsh [Y/n]? "
read answer
if echo "$answer" | grep -viq "^n" ; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    rm -rf ~/.oh-my-zsh/custom
    ln -fs `pwd`/.oh-my-zsh/custom ~/.oh-my-zsh/custom
    rm ~/.zshrc
    git submodule init && git submodule update
fi
echo "Finished installing oh-my-zsh"

echo -n "Install Tmux Plugin Manager [Y/n]? "
read answer
if echo "$answer" | grep -viq "^n" ; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "Finished installing Tmux Plugin Manager"

echo "Creating symlinks for dotfiles"
for i in "${files[@]}"; do
    if [ "`ls ~/$i 2> /dev/null`" == "" ]; then
        ln -sv "$PWD/$i" ~/"$i"
    fi
done

echo "Creating symlinks for scripts"
mkdir -p "~/.local/bin"
for i in scripts/*; do
    ln -sv "$PWD/$i" ~/.local/bin/"${i##*/}"
done
echo "Finished creating symlinks"

echo "Installing tmux-256color terminfo"
tic tmux-256color.ti
echo "Finished installing tmux-256color terminfo"
