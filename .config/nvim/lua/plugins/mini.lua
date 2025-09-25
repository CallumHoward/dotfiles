return {
  -- {
  --   "echasnovski/mini.indentscope",
  --   -- enabled = false,
  --   config = {
  --     draw = {
  --       animation = require("mini.indentscope").gen_animation.none(),
  --     },
  --   },
  -- },
  {
    "nvim-mini/mini.surround",
    keys = { "v", "S" },
    opts = function()
      -- Remap adding surrounding to Visual mode selection
      -- vim.keymap.del("x", "ys")
      vim.keymap.set(
        "x",
        "S",
        [[:<C-u>lua MiniSurround.add('visual')<CR>]],
        { silent = true, desc = "Add surrounding for selection" }
      )

      -- Make special mapping for "add surrounding for line"
      vim.keymap.set("n", "yss", "ys_", { remap = true, desc = "Add surrounding" })

      return {
        mappings = {
          add = "ys", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "]f", -- Find surrounding (to the right)
          find_left = "[f", -- Find surrounding (to the left)
          highlight = "ysh", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`

          suffix_last = "n",
          suffix_next = "l",
        },
      }
    end,
  },
}
