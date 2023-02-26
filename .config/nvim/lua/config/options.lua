-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local vo = vim.opt

vo.diffopt = "internal,filler,closeoff,iwhite,vertical,algorithm:patience,indent-heuristic"
vo.fillchars:append("diff:╱")

vo.iskeyword:append("-") -- Treat dash separated words as a word text object"

vo.linebreak = true -- Wrap long lines at characters in 'breakat'
vo.breakindent = true -- Wrapped text is indented
vo.breakindentopt = "sbr,shift:0,min:20" -- Config for breakindent
vo.showbreak = "↳ "
vo.breakat = " ,{"
vo.cpoptions:append("n") -- Column calc for wrapped lines

vo.foldmethod = "expr"
vo.foldexpr = "nvim_treesitter#foldexpr()"
vo.foldenable = false
