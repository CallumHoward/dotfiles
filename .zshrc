# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="ys"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Set term which supports italics
#infocmp tmux-256color >& /dev/null;
#if [ $? -eq 0 ]; then
#    export TERM=tmux-256color
#fi

# Plugins to load (can be found in ~/.oh-my-zsh/plugins/*)
plugins=( \
    #docker \
    #meteor \
    #mosh \
    #npm \
    #vi-mode \
    zsh-vim-mode \
    proxy-title \
    pip \
    fasd \
    history-substring-search \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-system-clipboard \
    history-search-multi-word \
)

source $ZSH/oh-my-zsh.sh
source ~/.shell_exports
source ~/.shell_aliases
source ~/.zsh_aliases
source ~/.zsh_keybindings
source ~/.zsh_styles
source ~/.zsh_functions

bindkey -M viins 'kj' vi-cmd-mode

setopt complete_aliases

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# git info for prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git #svn
add-zsh-hook precmd vcs_info

# gitsome completion
if [ -d .gitsome ]; then
    autoload bashcompinit
    bashcompinit
    source ~/.gitsome/gh_complete.sh
fi

