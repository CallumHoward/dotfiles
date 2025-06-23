vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.list = false
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorline = false
vim.opt_local.spell = false

-- Used for legacy non-treesitter highlighting
vim.g.markdown_fenced_languages = {
  "bash=sh", "c", "cmake", "cpp", "cs", "csharp=cs", "css",
  "diff", "go", "html", "java", "javascript", "js=javascript", "ts=typescript",
  "json", "less", "make", "php", "python", "ruby", "rust", "scss", "sh",
  "shell=sh", "sql", "vim", "xml", "yaml", "zsh", "tsx=typescript", "jsx=javascript"
}