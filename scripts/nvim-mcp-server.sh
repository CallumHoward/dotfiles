#!/bin/bash
set -euo pipefail
# Wrapper that finds the Neovim socket matching $PWD, then launches mcp-neovim-server.
# Used as the MCP server command in Claude Code settings.

best_len=0
for sock in "${TMPDIR}nvim.$(whoami)"/*/nvim.*; do
  cwd=$(nvim --server "$sock" --remote-expr 'getcwd()' 2>/dev/null) || continue
  case "$PWD" in
  "$cwd"*)
    len=${#cwd}
    if [ "$len" -gt "$best_len" ]; then
      best_len=$len
      export NVIM_SOCKET_PATH="$sock"
    fi
    ;;
  esac
done

if [ -z "$NVIM_SOCKET_PATH" ]; then
  echo "No matching Neovim instance found for $PWD" >&2
  exit 1
fi

exec npx -y mcp-neovim-server
