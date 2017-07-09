set background=dark

highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "neodark"


highlight SpecialKey     ctermfg=12
highlight link           EndOfBuffer NonText
highlight TermCursor     cterm=reverse
"highlight TermCursorNC   cleared
highlight NonText        ctermfg=12
highlight Directory      ctermfg=6
highlight ErrorMsg       ctermfg=15 ctermbg=1
highlight IncSearch      ctermfg=3 ctermbg=8 cterm=underline
highlight Search         ctermfg=3 ctermbg=8 cterm=underline
highlight MoreMsg        ctermfg=2
highlight ModeMsg        cterm=bold
highlight LineNr         ctermfg=11
highlight CursorLineNr   cterm=none ctermfg=14 ctermbg=8
highlight Question       ctermfg=2
highlight StatusLine     cterm=bold,reverse
highlight StatusLineNC   cterm=reverse ctermfg=15 ctermbg=11
highlight VertSplit      cterm=reverse ctermfg=15
highlight Title          ctermfg=5
highlight Visual         ctermbg=12
highlight WarningMsg     ctermfg=1
highlight WildMenu       ctermfg=0 ctermbg=11
highlight Folded         ctermfg=4 ctermbg=none
highlight FoldColumn     ctermfg=4 ctermbg=none

highlight DiffAdd        ctermfg=83 ctermbg=10
highlight DiffChange     ctermbg=10
highlight DiffDelete     cterm=bold ctermfg=160 ctermbg=10
highlight DiffText       cterm=none ctermfg=191 ctermbg=0
highlight SignColumn     ctermfg=11 ctermbg=none
"highlight Conceal        ctermfg=7 ctermbg=242

highlight SpellBad       cterm=underline ctermbg=none ctermfg=167
highlight SpellCap       cterm=underline ctermbg=none ctermfg=167
highlight SpellRare      cterm=underline ctermbg=none ctermfg=none
highlight SpellLocal     cterm=underline ctermbg=none ctermfg=none

highlight Pmenu          ctermfg=7 ctermbg=10
highlight PmenuSel       ctermfg=15 ctermbg=11
highlight PmenuSbar      ctermbg=10
highlight PmenuThumb     ctermbg=11
highlight TabLine        cterm=none ctermfg=4 ctermbg=10
highlight TabLineSel     cterm=none ctermfg=6 ctermbg=12
highlight TabLineFill    ctermfg=0 ctermbg=0
"highlight CursorColumn   ctermbg=7
highlight CursorLine     cterm=none ctermbg=8
"highlight ColorColumn    ctermbg=224

highlight MatchParen     cterm=bold ctermbg=none ctermfg=15
highlight Comment        ctermfg=4 cterm=italic
highlight Constant       ctermfg=1
highlight Special        ctermfg=5
highlight Identifier     cterm=none ctermfg=6
highlight Statement      ctermfg=14
highlight PreProc        ctermfg=5
highlight Type           ctermfg=2
highlight Underlined     cterm=underline ctermfg=5
highlight Ignore         ctermfg=15
highlight Error          ctermfg=15 ctermbg=none cterm=underline
highlight Todo           ctermfg=4 ctermbg=10 cterm=bold,italic

highlight link           QuickFixLine   Visual

"highlight link           String         Constant
"highlight link           Character      Constant
"highlight link           Number         Constant
"highlight link           Boolean        Constant
"highlight link           Float          Number
"highlight link           Function       Identifier
"highlight link           Conditional    Statement
"highlight link           Repeat         Statement
"highlight link           Label          Statement
"highlight link           Operator       Statement
"highlight link           Keyword        Statement
"highlight link           Exception      Statement
"highlight link           Include        PreProc
"highlight link           Define         PreProc
"highlight link           Macro          PreProc
"highlight link           PreCondit      PreProc
"highlight link           StorageClass   Type
"highlight link           Structure      Type
"highlight link           Typedef        Type
"highlight link           Tag            Special
"highlight link           SpecialChar    Special
"highlight link           Delimiter      Special
"highlight link           SpecialComment Special
"highlight link           Debug          Special

" tweaks for octol/vim-cpp-enhanced-highlight
highlight Function ctermfg=7
highlight cCustomClass ctermfg=14
highlight cppSTLnamespace ctermfg=13
highlight cppSTLconstant ctermfg=14
highlight cppSTLtype ctermfg=14

" neovimhaskell/haskell-vim
highlight haskellSeparator ctermfg=14
highlight haskellDelimiter ctermfg=14
highlight haskellWhere ctermfg=14
highlight haskellLet ctermfg=14
highlight haskellDeclKeyword ctermfg=14
highlight haskellDecl ctermfg=14
highlight haskellForeignKeywords ctermfg=14

" neosnippet
highlight neosnippetConcealExpandSnippets ctermfg=5

" netrw
highlight netrwTreeBar ctermfg=0

" tagbar
highlight link TagbarHighlight Visual
