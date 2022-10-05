require("nvim-treesitter.configs").setup({
  ensure_installed = "all",

  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },

  indent = {
    enable = true,
  },

  -- nvim-ts-context-commentstring config
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      c = "// %s",
      cpp = "// %s",
    },
  },

  autotag = {
    enable = true,
  },

  -- nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["]a"] = "@parameter.inner",
        ["<M-l>"] = "@parameter.inner",
      },
      swap_previous = {
        ["[a"] = "@parameter.inner",
        ["<M-h>"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]f"] = "@function.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]F"] = "@function.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[f"] = "@function.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[F"] = "@function.outer",
      },
      ["[]"] = "@class.outer",
    },
  },
})
