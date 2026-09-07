# Live git prompt for powerlevel10k: watch the current repo with fswatch and
# re-query gitstatus on change so the vcs segment refreshes while the prompt is
# idle. Event-driven, so idle cost is zero. Requires fswatch.

(( $+commands[fswatch] )) || return 0
zmodload zsh/zpty || return 0
autoload -Uz add-zsh-hook

typeset -g  _live_git_root=      # repo currently being watched
typeset -g  _live_git_pwd=       # last PWD checked, to skip git when unchanged
typeset -gi _live_git_fd=-1
: ${LIVE_GIT_LATENCY:=0.5}

_live_git_stop() {
  (( _live_git_fd >= 0 )) && zle -F $_live_git_fd 2>/dev/null
  zpty -d live_git 2>/dev/null
  _live_git_fd=-1
  _live_git_root=
}

# Kick off p10k's async gitstatus query; the result callback redraws the prompt.
_live_git_refresh() {
  (( $+functions[_p9k_vcs_gitstatus] )) || return 0
  local -i _p9k__vcs_called
  _p9k__refresh_reason=precmd
  _p9k_vcs_gitstatus
  _p9k__refresh_reason=''
}

_live_git_on_event() {
  local line
  if [[ -n $2 ]]; then
    _live_git_stop
    _live_git_pwd=
    return
  fi
  while zpty -r -t live_git line 2>/dev/null; do :; done
  _live_git_refresh
}

_live_git_start() {
  setopt localoptions extendedglob
  local root=$1 git_dir=$2 common_dir=$3
  local -a paths=($root) excludes
  local dir ere_special='(#m)[\[.^$*+?(){}|\\]'

  [[ $git_dir != $root/* ]] && paths+=($git_dir)
  [[ $common_dir != $root/* && $common_dir != $git_dir ]] && paths+=($common_dir)

  # Skip git's own churn: objects, reflogs, fsmonitor, lock files.
  for dir in $git_dir ${common_dir:#$git_dir}; do
    dir=${dir//$~ere_special/\\$MATCH}
    excludes+=(
      -e "^$dir/(objects|logs|fsmonitor--daemon)(/|$)"
      -e "^$dir/fsmonitor--daemon\.ipc$"
      -e "^$dir/.*\.lock$"
      -e "^$dir/COMMIT_EDITMSG$"
    )
  done

  local -a opts=(--recursive --one-per-batch --extended --allow-overflow --latency $LIVE_GIT_LATENCY)
  [[ $OSTYPE == darwin* ]] && opts+=(--monitor-property darwin.eventStream.noDefer=true)

  # zpty gives fswatch a pty that dies with this shell, so no orphans on exit.
  zpty -b live_git command fswatch "${(@q)opts}" "${(@q)excludes}" -- "${(@q)paths}" || return 1
  _live_git_fd=$REPLY
  _live_git_root=$root
  zle -F $_live_git_fd _live_git_on_event
}

_live_git_precmd() {
  [[ $PWD == $_live_git_pwd ]] && return
  _live_git_pwd=$PWD

  local -a info
  info=(${(f)"$(command git rev-parse --show-toplevel --git-dir --git-common-dir 2>/dev/null)"})
  if (( $#info != 3 )); then
    _live_git_stop
    return
  fi

  local root=${info[1]:A}
  [[ $root == $_live_git_root ]] && return
  _live_git_stop
  _live_git_start $root ${info[2]:A} ${info[3]:A}
}

add-zsh-hook precmd _live_git_precmd
add-zsh-hook zshexit _live_git_stop
