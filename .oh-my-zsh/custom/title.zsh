# Runs before showing the prompt
function omz_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  local ICON=
  if [[ -f "package.json" ]]; then
      ICON=
  elif [[ "$PWD" =~ "dotfiles" ]]; then
      ICON=
  elif [[ -d ".git" ]]; then
      ICON=
  elif [[ "$PWD" = "$HOME" ]]; then
      ICON=
  fi
  title '$ICON $ZSH_THEME_TERM_TAB_TITLE_IDLE' $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function omz_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh
  setopt extended_glob

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"
  local ICON=""
  local COLOR=7

  case "$CMD" in
      "npm" | "npx" | "create-react-app")
          ICON= ;;
      "yarn")
          ICON=𝔂 ;;
      "brew" | "bu")
          ICON= ;;
      "vim" | "v" | "nvim" | "vi")
          ICON= ;;
      "python" | "python2" | "python3" | "pip" | "pip2" | "pip3" | "p" | "p3")
          ICON= ;;
      "ranger" | "ra")
          ICON=𝞤 ;;
      "man" | "less" | "cat" | "ls" | "ll" | "la" | "history" | "sort" | "uniq" | "head" | "tail" | "bat")
          ICON= ;;
      "y" | "youtube-dl" | "ytmdl" | "ym" | "yi")
          ICON= ;;
      "lldb" | "gdb")
          ICON= ;;
      "make" | "m" | "cmake")
          ICON= ;;
      "git" | "s" | "a" | "cm" | "gca" | "gd" | "gdmb" | "stash" | "pop" | "grs" | "show" | "lg" | "lgh" | "lgmb" | "push" | "co" | "com" | "cof" | "gmm" | "ba" | "baa" )
          ICON= ;;
      "top" | "htop" | "vtop" | "gtop")
          ICON= ;;
      "br" | "hub" | "gh")
          ICON= ;;
      "grep" | "ag" | "rg" | "find" | "fd")
          ICON= ;;
      "wget" | "curl")
          ICON= ;;
      "sudo" | "su")
          ICON= ;;
      "cd" | "open" | "o" | "oo" | "cdg")
          ICON= ;;
      "rm" | "trash")
          ICON= ;;
      "apt" | "apt-get")
          ICON=;;
      "cp" | "rsync" | "scp")
          ICON= ;;
      "docker" | "docker-compose")
          ICON= ;;
      "gcc" | "g++" | "clang" | "clang++")
          ICON= ;;
      "go")
          ICON= ;;
      "node")
          ICON= ;;
      "aws")
          ICON= ;;
      "ping" | "pg" | "pgh")
          ICON= ;;
      "time")
          ICON=祥;;
      "sleep")
          ICON=鈴;;

  esac

  title '$ICON $CMD' '%100>...>$LINE%<<'
}
