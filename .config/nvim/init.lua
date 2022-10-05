do
  local ok, _ = pcall(require, "impatient")
  -- require("impatient").enable_profile() -- uncommend and use :LuaCacheProfile

  if not ok then
    vim.notify("impatient.nvim not installed", vim.log.levels.WARN)
  end
end

require("plugins")
-- require("plugin_config")
require("base")
require("mappings")
require("commands")
-- require("functions")
require("autocommands")

vim.cmd("source ~/.config/nvim/mappings.vim")
vim.cmd("source ~/.config/nvim/extra.vim")
