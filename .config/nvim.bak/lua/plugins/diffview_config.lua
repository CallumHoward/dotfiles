-- DiffView config
local cb = require("diffview.config").diffview_callback
require("diffview").setup({
  enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  hooks = {
    diff_buf_read = function()
      vim.opt_local.wrap = false
      vim.opt_local.foldenable = true
    end,
  },
  key_bindings = {
    view = {
      ["]D"] = cb("select_next_entry"), -- Open the diff for the next file
      ["[D"] = cb("select_prev_entry"), -- Open the diff for the previous file
    },
  },
})
