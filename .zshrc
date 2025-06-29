#zmodload zsh/zprof

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
zle_highlight=("paste:none")

# Set name of the theme to load.
ZSH_CUSTOM=~/dotfiles/.oh-my-zsh/custom
#ZSH_THEME="ys"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Set term which supports italics
#infocmp tmux-256color >& /dev/null;
#if [ $? -eq 0 ]; then
#    export TERM=tmux-256color
#fi

# Required to be sourced before fasd plugin
PATH=~/.local/bin:$PATH

# Plugins to load (can be found in ~/.oh-my-zsh/plugins/*)
# NOTE load autosuggestions after syntax highlighting
# NOTE load history-search-multi-word after zsh-vim-mode
# NOTE load history-substring-search after zsh-syntax-highlighting
plugins=( \
    #docker \
    #meteor \
    #mosh \
    #npm \
    #vi-mode \
    # zsh-prompt-benchmark \ # enable when needed
    zsh-fzf-bindings \
    zsh-proxy-title \
    pip \
    npm \
    yarn \
    bun \
    fasd \
    zsh-zbell \
    # zsh-vim-mode goes before zsh-autocomplete, but then
    # history-search-multi-word highlighting doesn't work
    #zsh-vim-mode \
    #zsh-autocomplete \
    #zsh-syntax-highlighting \
    # history-substring-search \ # Broken since 35a5357704ace1d9732a15cc3a5d792df53f2170
    F-Sy-H \
    zsh-autosuggestions \
    zsh-vim-mode \
    H-S-MW \
)

source $ZSH/oh-my-zsh.sh
source ~/.shell_exports
source ~/.shell_aliases
source ~/.zsh_aliases
source ~/.zsh_keybindings
source ~/.zsh_styles
source ~/.zsh_functions
source ~/.local_rc

# should be sourced after keybindings
source $ZSH_CUSTOM/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh

# zsh-vim-mode config
#MODE_CURSOR_VICMD="underline" # colour does not seem to work in macOS term
#MODE_CURSOR_VIINS="bar"
#MODE_CURSOR_SEARCH="underline"
MODE_INDICATOR_VIINS='%B%K{2}%F{15} INSERT %f%k%b'
MODE_INDICATOR_VICMD='%B%K{4}%F{15} NORMAL %f%k%v'
MODE_INDICATOR_REPLACE='%B%K{1}%F{15} REPLACE %f%k%b'
MODE_INDICATOR_SEARCH='%B%K{2}%F{15} SEARCH %f%k%b'
MODE_INDICATOR_VISUAL='%B%K{9}%F{15} VISUAL %f%k%b'
MODE_INDICATOR_VLINE='%B%K{9}%F{15} V-LINE %f%k%b'

#setopt transientrprompt

# make the alias a distinct command for completion purposes
setopt complete_aliases

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# zsh-autosuggestions config
ZSH_AUTOSUGGEST_USE_ASYNC=1
#ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # not sure what this does: https://github.com/zsh-users/zsh-autosuggestions/commit/937d6fc24145fdcd87e952a5e607c26d098c58b5
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# ctrl-f alt-f to partially accept, right-arrow to fully accept
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-forward-char)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char forward-word)

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Refresh the prompt periodically
# TRAPALRM() {
#   local f
#   for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
#     [[ "${+functions[$f]}" == 0 ]] || "$f" &>/dev/null || true
#   done
#   p10k display -r
# }
# TMOUT=30

#zprof

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# export REACT_EDITOR=launch-editor-script.sh
# export REACT_EDITOR=echo
