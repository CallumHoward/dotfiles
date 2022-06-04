require("plugins")
require("plugin_config")
require("base")
require("mappings")
require("commands")
require("autocommands")
require("lsp")
require("lsp.emmet-ls")
require("lsp.lua-ls")
require("lsp.null-ls")
require("lsp.typescript-ls")
require("lsp.json-ls")

vim.cmd("source ~/.config/nvim/mappings.vim")
-- vim.cmd("source ~/.config/nvim/extra.vim")
