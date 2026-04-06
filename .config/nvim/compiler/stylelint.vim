CompilerSet makeprg=npx\ stylelint\ --formatter\ compact\ 'src/**/*.css'
CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m,
		       \%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m,
		       \%-G%.%#
let current_compiler = "stylelint"
