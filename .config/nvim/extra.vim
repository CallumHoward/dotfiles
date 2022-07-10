function! GetTitle() abort
    if tabpagenr('$') > 1
        return fnamemodify(getcwd(), ':t')
    " elseif filereadable(expand('%')) == 0
    "     return '[No Name]'
    else
        return expand('%:t')
    endif
endfunction

function! SetTmuxTitle() abort
    if !$DISABLE_AUTO_TITLE
        let title = GetTitle()
        if title != "" && title !~ "[Wilder"
            call system('tmux rename-window " ' . title . '"')
        else
            call system('tmux rename-window " nvim"')
        endif
    endif
endfunction

nnoremap <leader>ct :let $DISABLE_AUTO_TITLE=1

" set title for tmux
if exists('$TMUX')
    autocmd WinEnter,BufWinEnter,FocusGained,CmdlineLeave * call SetTmuxTitle()
    " autocmd FocusLost,VimLeave * call system("tmux setw automatic-rename")
endif

if has('nvim') && !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
    function! SetTerminalTitle() abort
        if bufname('%') != '' && bufname('%') !~ '^term'
            let titleString = 'file://'.expand('%:p:gs/\ /%20/')
        else
            let titleString = 'file://'.expand(getcwd())
            return
        endif

        " this is the format Terminal.app expects when setting the proxy icon
        if exists('$TMUX')
            let args = 'Ptmux;]7;'.titleString.'\\'
        else
            let args = ']7;'.titleString.''
        endif

        let cmd = 'call chansend(2, "'.args.'")'
        execute cmd
    endfunction

    autocmd WinEnter,BufWinEnter,FocusGained * call SetTerminalTitle()
endif

let g:python3_host_prog = '/usr/local/bin/python3'
let g:ultest_deprecation_notice = 0
