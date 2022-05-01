vim.api.nvim_create_user_command("LspVirtualTextHide", function()
  vim.diagnostic.config({ virtual_text = false })
end, {
  nargs = 0,
  desc = "Hide LSP virtual text",
})

vim.api.nvim_create_user_command("SynAttr", "call SyntaxAttr()", {
  desc = "Show the highlight group under cursor",
})
