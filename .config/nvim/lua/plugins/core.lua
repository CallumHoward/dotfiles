return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        autocmds = true,
        keymaps = false,
        options = true,
      },
      checker = {
        frequency = 172800, -- check for updates every two days
      },
    },
  },
  { "folke/flash.nvim", enabled = false },
}
