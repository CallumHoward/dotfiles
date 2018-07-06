
if [[ $TMUX ]]; then
    SHELL="zsh" zsh
    exit
fi

source ~/.shell_exports
source ~/.shell_aliases
source ~/.bash_functions
source ~/.bash_prompt
