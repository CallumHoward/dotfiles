setlocal wrap
setlocal linebreak
setlocal nolist
setlocal nonumber
setlocal norelativenumber
setlocal nocursorline
setlocal nospell

" Used for legacy non-treesitter highlighting
let g:markdown_fenced_languages = [
            \ 'bash=sh', 'c', 'cmake', 'cpp', 'cs', 'csharp=cs', 'css',
            \ 'diff', 'go', 'html', 'java', 'javascript', 'js=javascript', 'ts=typescript',
            \ 'json', 'less', 'make', 'php', 'python', 'ruby', 'rust', 'scss', 'sh',
            \ 'shell=sh', 'sql', 'vim', 'xml', 'yaml', 'zsh']
            "\ 'jsx', 'vue', 'swift',
