# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
# 
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || printf '%s\n' $HOST
}

YS_PWD_PROMPT_PREFIX1="%{$fg[yellow]%}"
YS_PWD_PROMPT_PREFIX2="%{$fg_bold[yellow]%}"
YS_PWD_PROMPT_SUFFIX="%{$reset_color%}"

# Directory info.
local current_dir='$(ys_cd_info)'

ys_cd_info() {
    local shortpath

    if [[ $COLUMNS -lt 80 ]]; then
        shortpath='%1~'
    elif [[ $COLUMNS -lt 100 ]]; then
        shortpath='%(5~|%-2~/.../%2~|%3~)'
    elif [[ $COLUMNS -lt 120 ]]; then
        shortpath='%(6~|%-3~/.../%2~|%5~)'
    else
        local vcsroot=${"$(git rev-parse --show-toplevel 2>/dev/null)"%[[:space:]][[:cntrl:]]}
        if ! [[ "$vcsroot" == "$PWD" ]]; then
            shortpath=${"${PWD}"#"${vcsroot%/*}/"}
        else
            shortpath=${${PWD}/"$HOME"/"~"}
        fi
    fi

    printf "%s%s%s" ${YS_PWD_PROMPT_PREFIX1} ${shortpath} ${YS_PWD_PROMPT_SUFFIX}
}

#ys_cd_info() {
#    local base=$(basename $PWD)
#    local dir="$(dirname $PWD | sed "s%^$HOME%\~%")/"
#
#    if [[ $PWD = "/" ]]; then
#        dir=""
#        base="/"
#    elif [[ "$dir" = "//" ]]; then
#        dir="/"
#    elif [[ "$PWD" = "$HOME" ]]; then
#        dir=""
#        base="~"
#    fi
#
#    if [[ $COLUMNS -gt 90 && dir != base ]]; then
#        printf "%s%s" ${YS_PWD_PROMPT_PREFIX1} ${dir}
#    fi
#
#    printf "%s%s%s" ${YS_PWD_PROMPT_PREFIX2} ${base} ${YS_PWD_PROMPT_SUFFIX}
#}


# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_PREFIX3="%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
#local hg_info='$(ys_hg_prompt_info)'
#ys_hg_prompt_info() {
#    # make sure this is a hg dir
#    if [ -d '.hg' ]; then
#        printf "%shg%s" ${YS_VCS_PROMPT_PREFIX1} ${YS_VCS_PROMPT_PREFIX2}
#        printf "%s" $(hg branch 2>/dev/null)
#        if [ -n "$(hg status 2>/dev/null)" ]; then
#            printf "%s" $YS_VCS_PROMPT_DIRTY
#        else
#            printf "%s" $YS_VCS_PROMPT_CLEAN
#        fi
#        printf "%s" $YS_VCS_PROMPT_SUFFIX
#    fi
#}

YS_VENV_PROMPT_PREFIX1=" %{$fg[white]%}using%{$reset_color%} "
YS_VENV_PROMPT_PREFIX2="%{$fg_bold[magenta]%}"
YS_VENV_PROMPT_SUFFIX="%{$reset_color%}"

# Python virtualenv info
local virtualenv_info='$(ys_virtualenv_prompt_info)'
ys_virtualenv_prompt_info() {
    local environment_str=""
    # Add virtualenv name if active
    if [ -n "${VIRTUAL_ENV}" ]; then
        local virtualenv_ref=$(basename $VIRTUAL_ENV)
        environment_str="${YS_VENV_PROMPT_PREFIX2}${virtualenv_ref}${YS_VENV_PROMPT_SUFFIX}"
        printf "%s%s" ${YS_VENV_PROMPT_PREFIX1} ${environment_str}
    fi
}

# Box info
local box_info='$(ys_box_info)'
ys_box_info() {
    if ! [[ "$COLUMNS" -lt 80 ]]; then
        if ! [[ -n "$BOX_NAME" ]]; then
            BOX_NAME=$(box_name)  # cache box name to avoid reading from disk
        fi
        printf "%%{%s%%}at %%{%s%%}%s " $fg[white] $fg[green] $BOX_NAME
    fi
}

# shell nested level
local nest_level='$(ys_nest_level)'
ys_nest_level() {
    if [[ -n "$TMUX" ]]; then
        local LVL=$(($SHLVL - 1))
    else
        local LVL=$SHLVL
    fi
    printf '#%.0s' {1..$LVL}
}

# Prompt Symbol
local prompt_symbol='$(ys_prompt_symbol)'
ys_prompt_symbol() {
    if [[ -n "${HISTFILE}" ]]; then
        printf "%%{%s%s%%}" $terminfo[bold] $fg[red]
    else
        printf "%%{%s%s%%}" $terminfo[bold] $fg[magenta]
    fi
    printf "$ %%{%s%%}" $reset_color
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
PROMPT="
%{$terminfo[bold]$fg[blue]%}${nest_level}%(1j.%j.)%{$reset_color%} \
%{$fg[cyan]%}%n \
${box_info}\
%{$fg[white]%}in \
${current_dir}\
${virtualenv_info}\
${git_info}
${prompt_symbol}"

if [[ "$USER" == "root" ]]; then
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[cyan]%}%{$fg[black]%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
${current_dir}\
${virtualenv_info}\
${git_info}
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
fi

SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
