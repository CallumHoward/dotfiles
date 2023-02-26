CompilerSet makeprg=yarn\ lint:style\ --formatter\ compact
CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m,
		       \%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m,
		       \%-G%.%#
let current_compiler = "stylelint"
