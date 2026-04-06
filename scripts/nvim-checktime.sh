#!/bin/bash
set -euo pipefail
# Trigger :checktime on Neovim instances whose CWD matches $PWD.
# Used as a Claude Code PostToolUse hook to auto-reload buffers after edits.

for sock in "${TMPDIR}nvim.$(whoami)"/*/nvim.*; do
  cwd=$(nvim --server "$sock" --remote-expr 'getcwd()' 2>/dev/null) || continue
  case "$PWD" in
  "$cwd"*) nvim --server "$sock" --remote-expr 'execute("checktime")' 2>/dev/null ;;
  esac
done
