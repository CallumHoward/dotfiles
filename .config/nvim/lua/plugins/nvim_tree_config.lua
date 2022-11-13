vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<CR>")

require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    group_empty = true,
    highlight_opened_files = "all",
    icons = {
      show = {
        git = false,
        folder = true,
        file = true,
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  diagnostics = {
    icons = {
      error = "",
      warning = "",
      hint = "",
      info = "",
    },
  },
  disable_netrw = true,
  filters = {
    dotfiles = true,
  },
})
vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<CR><cmd>:NvimTreeRefresh<CR>")
