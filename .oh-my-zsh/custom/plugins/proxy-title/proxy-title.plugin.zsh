#!/usr/bin/env zsh

# Terminal.app Set Title
# Set the proxy icon for OSX's Terminal.app to files/directories.

# Do not override precmd/preexec; append to the hook array.
autoload -Uz add-zsh-hook

# Encode to % escaped url string
urlEncode() {
    local string="${1}"
    local strlen=${#string}
    local encoded=""
    for (( pos=0 ; pos<strlen ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [/-_.~a-zA-Z0-9] ) o="${c}" ;;
            * ) printf -v o '%%%02x' "'$c"
        esac
        encoded+="${o}"
    done
    URL="file://$HOST${encoded}"
}

setIcon() {
    case $TERM in
         # TMUX escape to real shell
         screen*|tmux*)
             printf '\ePtmux;\e\e]%d;%s\a\e\\' $1 $2;;
         *)
             printf '\e]%d;%s\a' $1 $2;;
     esac
}

function _terminal-set-terminal-app-proxy-icon {
    if [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]; then
        # Check if directory
        urlEncode "$PWD"
        setIcon 7 $URL          # 7 is for directories, and are saved for resume
        # Ignore all other input
    fi
}
add-zsh-hook precmd _terminal-set-terminal-app-proxy-icon
