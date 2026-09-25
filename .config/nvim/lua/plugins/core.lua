vim.g.lazyvim_picker = "snacks"

return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        autocmds = true,
        keymaps = false,
        options = true,
      },
    },
  },
  { "folke/flash.nvim", enabled = false },
}
