cunmap <C-y>
call wilder#setup({
            \ 'modes': [':', '/', '?'],
            \ 'next_key': '<Tab>',
            \ 'previous_key': '<S-Tab>',
            \ 'accept_key': '<C-y>',
            \ 'reject_key': '<C-e>'
            \ })
call wilder#set_option('pipeline', [
            \ wilder#branch(
            \   [
            \     wilder#check({ctx, x -> empty(x)}),
            \     wilder#history(),
            \   ],
            \   wilder#cmdline_pipeline(),
            \   wilder#vim_search_pipeline(),
            \   wilder#python_file_finder_pipeline()
            \ )])
 call wilder#set_option('renderer', wilder#popupmenu_renderer({
            \ 'highlighter': wilder#basic_highlighter(),
            \ 'left': [' ', wilder#popupmenu_devicons()],
            \ 'right': [' ', wilder#popupmenu_scrollbar()],
            \ 'winblend': 18
            \ }))
