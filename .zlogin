#
# source: https://github.com/Eriner/zim
# startup file read in interactive login shells
#
# The following code helps us by optimizing the existing framework.
# This includes zcompile, zcompdump, etc.
#

(
    # Function to determine the need of a zcompile. If the .zwc file
    # does not exist, or the base file is newer, we need to compile.
    # These jobs are asynchronous, and will not impact the interactive shell
    zcompare() {
        if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
            zcompile ${1}
        fi
    }

    setopt EXTENDED_GLOB

    # zcompile the completion cache; siginificant speedup.
    for file in ${HOME}/.zcomp^(*.zwc)(.); do
        zcompare ${file}
    done

    # zcompile .zshrc
    zcompare ${HOME}/.zshrc
    zcompare ${HOME}/.zsh_functions
    zcompare ${HOME}/.zsh_aliases
    zcompare ${HOME}/.shell_aliases
    zcompare ${HOME}/.shell_exports
    zcompare ${HOME}/.zsh_keybindings

    zcompare ${ZSH_CUSTOM}/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh
) &!
