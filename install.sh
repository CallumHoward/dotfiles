#!/bin/bash

declare -a files=(
    '.config'
    '.gitconfig'
    '.gitignore_global'
    '.tmux.conf'

    '.vim'
    '.vimrc'
    #'.gvimrc'
    #'.xvimrc'
    '.ideavimrc'

    '.zshrc'
    '.zshenv'
    '.local_rc'
    #'.oh-my-zsh'
    '.shell_aliases'
    '.shell_exports'
    '.zsh_aliases'
    '.zsh_keybindings'
    '.zsh_styles'
    '.zsh_functions'
    '.p10k.zsh'
)

if [ "${PWD##*/}" != "dotfiles" ]; then
    echo "$0: run this script from inside the dotfiles directory"
    exit
fi

if ! [ -x "$(which brew)" ]; then
    echo -n "Install Homebrew [Y/n]? "
    if echo "$answer" | grep -viq "^n" ; then
        if [[ "$OSTYPE" =~ "darwin" ]]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew install reattach-to-user-namespace
        else
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
        fi
        echo -n "Install: tmux neovim ranger htop... [Y/n]? "
        if echo "$answer" | grep -viq "^n" ; then
            brew install tmux neovim ranger htop ripgrep fd exa fzf highlight hub universal-ctags fasd glow wakeonlan wget font-inconsolata-lgc-nerd-font
            brew install bat && bat cache --build
        fi
    fi
elif [ -x "$(which apt-get)" ]; then
    echo -n "Install: zsh ssh git tmux curl wget vim ranger cmake htop [Y/n]? "
    read answer
    if echo "$answer" | grep -viq "^n" ; then
        sudo apt-get install zsh ssh git tmux curl wget vim ranger cmake htop
    fi
fi
echo "Finished installing packages"

git update-index --skip-worktree .local_rc

echo -n "Install ranger-devicons [Y/n]? "
read answer
if echo "$answer" | grep -viq "^n" ; then
  pip install ansicolors
fi

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
mkdir -p ~/.local/bin # don't quote this
for i in scripts/*; do
    ln -sv "$PWD/$i" ~/.local/bin/"${i##*/}"
done
ln -sv "$PWD/.config/ranger/scope.sh" ~/.local/bin/scope
echo "Finished creating symlinks"

echo "Downloading diff-so-fancy"
wget "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" -O ~/.local/bin/diff-so-fancy
chmod +x ~/.local/bin/diff-so-fancy
wget "https://raw.githubusercontent.com/wincent/wincent/master/aspects/dotfiles/files/.zsh/bin/menos" -O ~/.local/bin/menos
chmod +x ~/.local/bin/menos
echo "Finished installing diff-so-fancy"

echo "Installing tmux-256color terminfo"
tic tmux-256color.ti
echo "Finished installing tmux-256color terminfo"

echo "Setting Zsh fast-syntax-highlighting theme"
zsh -c "fast-theme -t ./neodark-zsh.ini"
echo "Finished setting Zsh fast-syntax-highlighting theme"
