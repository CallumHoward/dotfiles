#!/bin/bash

if [ "$1" = "--" ]; then
  shift
fi

IFS=':' read -ra parts <<<"$1"
filename=${parts[0]}
line=${parts[1]:-1}
column=${parts[2]:-1}

# <C-\\><C-N> -> go to normal mode, open file, navigate to correct line and column
command="<C-\\><C-N>:n $filename<CR>:call cursor($line,$column)<CR>:lua vim.fn.system('tmux select-window -t ' .. vim.g.tmux_window_target)<CR>"

# nvim default sockets are always nested somewhere in here
# see: https://github.com/neovim/neovim/blob/7c661207cc4357553ed2b057b6c8f28400024361/src/nvim/msgpack_rpc/server.c# L89
socket_directory="${TMPDIR}nvim.${USER}"
# use find to, well, find them all! (-type s -> socket)
nvim_sockets=($(find "$socket_directory" -type s))

for socket in "${nvim_sockets[@]}"; do
  # now it gets nasty...
  # socket is of shape something.user.pid.count
  # so to get the pid we do this:
  # replace "dots" in socket with linebreaks and return the second to last line (the pid)
  pid=($(echo $socket | tr "." "\n" | tail -n 2 | head -1))

  # now we want to get the cwd this process is running in
  # use lsof to get table for this pid, grep row with file descriptor cwd
  # now replace spaces in row with linebreaks and return the second to last line (the pid)
  pid_cwd=($(lsof -p $pid | grep cwd | tr " " "\n" | tail -n 1))
  git_root=($(git rev-parse --show-toplevel 2>/dev/null))

  # only if process cwd is the same as the pwd, run the command
  if [[ $git_root == $pid_cwd ]]; then
    # open Kitty.app to focus the terminal
    nvim --server $socket --remote-send "$command" && open -a Kitty.app
    exit 0
  elif [[ $git_root == "" ]] && [[ $filename =~ $pid_cwd ]]; then
    nvim --server $socket --remote-send "$command" && open -a Kitty.app
    exit 0
  fi

done

echo "No nvim instance found for $filename" >&2
exit 1
