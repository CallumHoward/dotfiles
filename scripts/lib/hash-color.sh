#!/usr/bin/env bash
# Shared color-hash library. Source me from bash scripts.
#
#   hash_key DIR   -> sets HASH_KEY (canonicalized branch / fallback name)
#                     and HASH_BRANCH (raw branch, or empty if not in a repo)
#   hash_color KEY -> sets HASH_COLOR to an ANSI base-color index
#
# Pure bash, no `shasum` subprocess — fast enough to call inline. One git
# invocation per hash_key (combined --abbrev-ref + --show-toplevel).
#
# The palette is the 12 base ANSI colors (red..cyan + bright variants),
# skipping black/white/grey so foregrounds stay readable on any background.
# The terminal's own theme renders each index. Reference as:
#   tmux:   #[fg=colour${HASH_COLOR}]
#   ANSI:   printf '\033[38;5;%dm' "$HASH_COLOR"
#
# Canonicalization: main, master, and any branch matching the worktree-root
# basename (bare-repo numbered-worktree convention) all collapse to "main".

# colour4 (ANSI blue, non-bright) is reserved for canonical-main sessions —
# main/master/worktree-tracking — and excluded from the hashing palette so it
# never gets randomly assigned to a feature branch.
#
# Hash palette is a Tokyo-Night-aligned selection from the 256-color cube,
# spread around the hue wheel for visual distinctness. colour111 (light blue)
# is deliberately omitted because it reads as the same hue family as colour4
# in this theme — a branch hashing to it would look like main at a glance.
HC_MAIN_COLOR=4
HC_PALETTE=(211 215 179 149 115 117 141 213 175)

# FNV-1a 32-bit, pure bash. Folds upper bits into lower at the end (xor-shift)
# so a small modulo (12 palette slots) uses well-mixed bits rather than just
# the low 4 of the raw FNV output — reduces collisions on similarly-prefixed
# inputs (e.g. branches with a common JIRA prefix).
_hash_fnv1a32() {
  local s=$1 h=2166136261 i c
  for ((i=0; i<${#s}; i++)); do
    printf -v c '%d' "'${s:i:1}"
    h=$(( (h ^ c) * 16777619 & 0xffffffff ))
  done
  HASH_INT=$(( (h ^ (h >> 16)) & 0xffffffff ))
}

hash_key() {
  local cwd=$1 toplevel="" root_name
  HASH_BRANCH=""
  # `git rev-parse ARG1 ARG2` prints each result on its own line, not
  # space-separated, so read both lines explicitly.
  {
    read -r HASH_BRANCH
    read -r toplevel
  } < <(git -C "$cwd" rev-parse --abbrev-ref HEAD --show-toplevel 2>/dev/null)
  [ "$HASH_BRANCH" = "HEAD" ] && HASH_BRANCH=""  # detached
  if [ -n "$HASH_BRANCH" ]; then
    root_name=${toplevel##*/}
    case "$HASH_BRANCH" in
      main|master|"$root_name") HASH_KEY="main" ;;
      *) HASH_KEY=$HASH_BRANCH ;;
    esac
  else
    HASH_KEY=${cwd##*/}
  fi
}

hash_color() {
  local key=$1 n i
  if [ "$key" = "main" ]; then
    HASH_COLOR=$HC_MAIN_COLOR
    return
  fi
  _hash_fnv1a32 "$key"
  n=${#HC_PALETTE[@]}
  i=$(( HASH_INT % n ))
  [ "$i" -lt 0 ] && i=$(( i + n ))
  HASH_COLOR=${HC_PALETTE[$i]}
}
