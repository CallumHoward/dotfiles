vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class",
  "function",
  "method",
  "block",
  "list_literal",
  "selector",
  "^if",
  "^table",
  "if_statement",
  "while",
  "for",
  "arguments",
  "switch_statement",
  "switch_case",
  "switch_default",
  "jsx_element",
  "open_tag",
  "object",
  "object_type",
  "parenthesized_expression",
  "jsx_self_closing_element",
}
vim.g.indent_blankline_context_highlight_list = { "NonText" }
vim.g.indent_blankline_buftype_exclude = { "nofile", "terminal" }
vim.g.indent_blankline_filetype_exclude = { "qf", "vista_kind", "terminal", "packer", "help", "UltestSummary" }
