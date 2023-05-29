vim.loader.enable()

require("plugins")
-- require("plugin_config")
require("base")
require("mappings")
require("commands")
-- require("functions")
require("autocommands")

vim.cmd("source ~/.config/nvim/mappings.vim")
vim.cmd("source ~/.config/nvim/extra.vim")
