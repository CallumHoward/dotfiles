# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="ys"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Set term which supports italics
infocmp tmux-256color >& /dev/null;
if [ $? -eq 0 ]; then
    export TERM=tmux-256color
fi

# Plugins to load (can be found in ~/.oh-my-zsh/plugins/*)
plugins=( \
    docker \
    git \
    history-search-multi-word \
    history-substring-search \
    meteor \
    mosh \
    npm \
    pip \
    vi-mode \
    virtualenv \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
)

source $ZSH/oh-my-zsh.sh
source ~/.shell_aliases
source ~/.shell_exports
source ~/.zsh_keybindings
source ~/.zsh_styles
source ~/.zsh_functions

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# gitsome completion
if [ -d .gitsome ]; then
    autoload bashcompinit
    bashcompinit
    source ~/.gitsome/gh_complete.sh
fi

