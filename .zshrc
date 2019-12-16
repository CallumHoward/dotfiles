# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#export ZSH_DISABLE_COMPFIX="true"  # load insecure completions
DISABLE_MAGIC_FUNCTIONS="true"  # disable url quote magic

# Set name of the theme to load.
ZSH_CUSTOM=~/dotfiles/.oh-my-zsh/custom
ZSH_THEME="ys"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Set term which supports italics
#infocmp tmux-256color >& /dev/null;
#if [ $? -eq 0 ]; then
#    export TERM=tmux-256color
#fi

# Plugins to load (can be found in ~/.oh-my-zsh/plugins/*)
# NOTE load autosuggestions after syntax highlighting
# NOTE load history-search-multi-word after zsh-vim-mode
plugins=( \
    #docker \
    #meteor \
    #mosh \
    #npm \
    #vi-mode \
    zsh-prompt-benchmark \
    zsh-fzf-bindings \
    proxy-title \
    pip \
    fasd \
    zsh-zbell \
    history-substring-search \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    #zsh-vim-mode \
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
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git #svn
#add-zsh-hook precmd vcs_info

# zsh-autosuggestions config
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

