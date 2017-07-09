# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="ys"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git vi-mode history-substring-search zsh-autosuggestions virtualenv zsh-syntax-highlighting history-search-multi-word docker cabal aws meteor npm pip)

source $ZSH/oh-my-zsh.sh
source ~/.shell_aliases
source ~/.shell_exports
source ~/.zsh_keybindings
source ~/.zsh_styles
source ~/.zsh_functions

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# gitsome completion
autoload bashcompinit
bashcompinit
source ~/.gitsome/gh_complete.sh

