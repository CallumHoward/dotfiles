return {
  {
    "nvim-mini/mini.ai",
    opts = function(_, opts)
      opts.custom_textobjects = opts.custom_textobjects or {}
      opts.custom_textobjects.L = function()
        local line_num = vim.fn.line(".")
        local line = vim.fn.getline(line_num)
        local from_col = line:match("^(%s*)"):len() + 1
        local to_col = line:len()
        return { from = { line = line_num, col = from_col }, to = { line = line_num, col = to_col } }
      end
      LazyVim.on_load("which-key.nvim", function()
        vim.schedule(function()
          require("which-key").add({
            mode = { "o", "x" },
            { "aL", desc = "line" },
            { "iL", desc = "line" },
          })
        end)
      end)
      return opts
    end,
  },
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
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
        custom_surroundings = {
          B = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
        },
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
