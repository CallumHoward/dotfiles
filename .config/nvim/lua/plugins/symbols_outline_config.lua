-- Symbols outline config
require("symbols-outline").setup({
  width = 16,
  show_symbol_details = false,
  symbols = require("plugins.shared.symbols"),
})

vim.api.nvim_exec([[ autocmd Filetype Outline setl nowrap ]], true)

vim.keymap.set("<leader><Tab>", "<cmd>SymbolsOutline<CR>")
