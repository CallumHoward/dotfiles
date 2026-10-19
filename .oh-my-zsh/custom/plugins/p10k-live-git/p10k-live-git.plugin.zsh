# Live git prompt for powerlevel10k: watch the current repo with fswatch and
# re-query gitstatus on change so the vcs segment refreshes while the prompt is
# idle. Event-driven, so idle cost is zero. Requires fswatch.

(( $+commands[fswatch] )) || return 0
zmodload zsh/zpty zsh/datetime || return 0
autoload -Uz add-zsh-hook

typeset -g  _live_git_root=      # repo currently being watched
typeset -g  _live_git_pwd=       # last PWD checked, to skip git when unchanged
typeset -gi _live_git_fd=-1
: ${LIVE_GIT_QUIET:=0.3}         # refresh once changes go quiet for this long
: ${LIVE_GIT_MAX_WAIT:=2}        # but at least this often under sustained churn

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

# Sets REPLY to $1 escaped for use in an ERE.
_live_git_ere() {
  setopt localoptions extendedglob
  local special='(#m)[\[.^$*+?(){}|\\]'
  REPLY=${1//$~special/\\$MATCH}
}

# Emits one line per burst of events. A refresh landing while gitstatus is
# still querying makes p10k repaint the segment as loading, hence the flicker.
_live_git_debounce() {
  local line
  local -F deadline
  while read -r line; do
    (( deadline = EPOCHREALTIME + LIVE_GIT_MAX_WAIT ))
    while (( EPOCHREALTIME < deadline )) && read -r -t $LIVE_GIT_QUIET line; do :; done
    print
  done
}

# Runs in the zpty child so the ignored-dir scan never blocks the prompt. Dirs
# that become ignored later stay watched until the repo is re-entered.
_live_git_watch() {
  local root=$1 git_dir=$2 common_dir=$3 dir
  local -a paths=($root) filters ignored

  # Skip git's own churn: objects, reflogs, fsmonitor, lock files, no-op fetches.
  for dir in $git_dir ${common_dir:#$git_dir}; do
    _live_git_ere $dir
    filters+=(
      -e "^$REPLY/(objects|logs)(/|$)"
      -e "^$REPLY/fsmonitor--daemon"
      -e "^$REPLY/.*\.lock$"
      -e "^$REPLY/(COMMIT_EDITMSG|FETCH_HEAD)$"
    )
  done

  [[ $common_dir != $root/* ]] && paths+=($common_dir)
  [[ $git_dir != ($root|$common_dir)(|/*) ]] && paths+=($git_dir)

  if [[ $git_dir != $common_dir ]]; then
    # Linked worktree: skip state owned by the main and sibling worktrees.
    # An include overrides every exclude, so keep includes to plain files.
    _live_git_ere $common_dir
    filters+=(-e "^$REPLY/[^/]+$" -i "^$REPLY/(packed-refs|config)$")
    for dir in $common_dir/worktrees/*(/N); do
      [[ $dir == $git_dir ]] && continue
      _live_git_ere $dir
      filters+=(-e "^$REPLY(/|$)")
    done
  fi

  ignored=(${(0)"$(command git -C $root ls-files -z -oi --exclude-standard --directory 2>/dev/null)"})
  _live_git_ere $root
  local base=$REPLY
  for dir in ${(M)ignored:#*/}; do
    _live_git_ere ${dir%/}
    filters+=(-e "^$base/$REPLY(/|$)")
  done

  # Latency stays under LIVE_GIT_QUIET so batches coalesce in the debounce.
  local -a opts=(--recursive --one-per-batch --extended --allow-overflow --latency 0.1)
  [[ $OSTYPE == darwin* ]] && opts+=(--monitor-property darwin.eventStream.noDefer=true)

  command fswatch $opts $filters -- $paths | _live_git_debounce
}

_live_git_start() {
  # zpty gives the watcher a pty that dies with this shell, so no orphans on exit.
  zpty -b live_git _live_git_watch "${(@q)@}" || return 1
  _live_git_fd=$REPLY
  _live_git_root=$1
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
