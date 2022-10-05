-- Winbar breadcrumps navigator config

local symbols = require("plugins.shared.symbols")

local icons = {}
for key, value in pairs(symbols) do
  icons[key] = value.icon .. " "
  vim.api.nvim_set_hl(0, value.navic_hl, { link = value.hl })
end

require("nvim-navic").setup({
  highlight = true,
  separator = " › ",
  depth_limit = 5,
  icons = icons,
})

vim.api.nvim_set_hl(0, "NavicText", { link = "Comment" })
vim.api.nvim_set_hl(0, "NavicSeparator", { link = "WhiteSpace" })
