local space = "    "

local function push_to_jumplist()
  -- Get the current cursor position
  local current_position = vim.api.nvim_win_get_cursor(0)

  -- Set a mark at the current position to push it to the jump list
  vim.api.nvim_buf_set_mark(0, "'", current_position[1], 0, {})
end

return {
  {
    "kwkarlwang/bufjump.nvim",
    keys = { "<M-o>", "<M-i>" },
    config = function()
      local bj = require("bufjump")
      vim.keymap.set("n", "<M-o>", bj.backward, { desc = "Jump to back by Buffer" })
      vim.keymap.set("n", "<M-i>", bj.forward, { desc = "Jump to forward by Buffer" })
    end,
  },
  { "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } },
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    config = {
      handlers = {
        jira = { -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
          name = "jira", -- set name of handler
          handle = function(mode, line, _)
            local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
            if ticket and #ticket < 20 then
              return "http://safetyculture.atlassian.net/browse/" .. ticket
            end
          end,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      preview_config = { border = "none" },
      current_line_blame = true,
      current_line_blame_opts = { virt_text_priority = 1 },
      current_line_blame_formatter = space .. "<author>, <author_time:%R> • <summary>",
      current_line_blame_formatter_nc = space .. "You, a while ago • Uncommitted changes",
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev hunk" })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>ub", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff with base" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff with HEAD" })
        map("n", "<leader>gc", function()
          gs.toggle_deleted()
          gs.toggle_word_diff()
          gs.toggle_linehl()
        end, { desc = "Toggle changes" })
        -- stylua: ignore
        map("n", "<leader>ggm", function() gs.change_base("master", true) end, { desc = "Diff master" })
        -- stylua: ignore
        map("n", "<leader>ggM", function() gs.change_base("main", true) end, { desc = "Diff main" })
        -- stylua: ignore
        map("n", "<leader>ggh", function() gs.change_base("HEAD", true) end, { desc = "Diff HEAD" })
        map("n", "<leader>ggf", function()
          gs.change_base("FILE", true)
        end, { desc = "Diff saved" })
        map("n", "<leader>gb", function()
          local windows = vim.api.nvim_list_wins()
          for _, win in ipairs(windows) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.fn.getbufvar(buf, "&filetype") == "gitsigns-blame" then
              vim.api.nvim_win_close(win, true)
              return
            end
          end
          vim.cmd("Gitsigns blame")
          vim.defer_fn(function()
            vim.cmd("wincmd l")
          end, 100)
        end, { desc = "Diff blame" })
        map("n", "<leader>hl", "<cmd>Gitsigns setqflist<CR>", { desc = "List hunks" })
        map(
          "n",
          "<leader>gg",
          ":lua require('gitsigns').change_base('HEAD~', true)<Left><Left><Left><Left><Left><Left><Left><Left>",
          { desc = "Diff with ref (prompt)" }
        )

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
      end,
    },
  },
  {
    "vuki656/package-info.nvim",
    -- dependencies = "MunifTanjim/nui.nvim",
    event = "BufEnter package.json",
    config = function()
      require("package-info").setup({
        hide_up_to_date = true,
      })
    end,
    keys = function()
      -- vim.keymap.set("n", "<leader>ns", require("package-info").show, { desc = "Show dependency versions" })
      -- vim.keymap.set("n", "<leader>nc", require("package-info").hide, { desc = "Hide dependency versions" })
      -- vim.keymap.set("n", "<leader>nt", require("package-info").toggle, { desc = "Toggle dependency versions" })
      -- vim.keymap.set("n", "<leader>nu", require("package-info").update, { desc = "Update dependency on the line" })
      -- vim.keymap.set("n", "<leader>nd", require("package-info").delete, { desc = "Delete dependency on the line" })
      -- vim.keymap.set("n", "<leader>ni", require("package-info").install, { desc = "Install a new dependency" })
      -- vim.keymap.set(
      --   "n",
      --   "<leader>np",
      --   require("package-info").change_version,
      --   { desc = "Install a different dependency version" }
      -- )
    end,
  },
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>q",
        keys = {
          {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
          },
        },
      },
    },
    opts = {
      auto_preview = false,
      keys = {
        ["<space>"] = "fold_toggle",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    enabled = false,
    keys = {
      { "]t", false },
      { "[t", false },
    },
    opts = {
      highlight = {
        after = "",
      },
    },
  },
  {
    "linrongbin16/gitlinker.nvim",
    lazy = true,
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gO", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git permlink" },
      { "<leader>gB", "<cmd>GitLink! blame<cr>", mode = { "n", "v" }, desc = "Open git blame" },
    },
  },
  {
    "tpope/vim-abolish",
    event = "BufWinEnter",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>S",
        "<cmd>set icm=split<CR>:%Subvert/<C-r>///g<Left><Left>",
        { remap = true, desc = "Subvert" }
      )
      vim.keymap.set(
        "x",
        "<leader>S",
        "<cmd>set icm=split<CR>:Subvert/<C-r>///g<Left><Left>",
        { remap = true, desc = "Subvert" }
      )
    end,
  },
  {
    "fuadsaud/vim-textobj-variable-segment",
    dependencies = { "kana/vim-textobj-user" },
    event = "VeryLazy",
  },
  {
    -- Disable default <tab> and <s-tab> behaviour provided by LazyVim
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    ft = {
      "bash",
      "elixir",
      "fish",
      "julia",
      "lua",
      "luau",
      "ruby",
      "verilog",
      "vim",
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = { enable_close_on_slash = false },
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
    },
  },
  {
    "axelvc/template-string.nvim",
    lazy = true,
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
    },
    config = function()
      require("template-string").setup({
        remove_template_string = true,
        restore_quotes = {
          normal = [["]],
          jsx = [["]],
        },
      })
    end,
  },
  {
    "domharries/foldnav.nvim",
    event = "VeryLazy",
    keys = {
      -- stylua: ignore start
      { "[z", function() push_to_jumplist() require("foldnav").goto_start() end },
      { "<M-]>", function() push_to_jumplist() require("foldnav").goto_next() end },
      { "<M-[>", function() push_to_jumplist() require("foldnav").goto_prev_start() end },
      { "zj", function() push_to_jumplist() require("foldnav").goto_next() end },
      { "zk", function() push_to_jumplist() require("foldnav").goto_prev_start() end },
      { "]z", function() push_to_jumplist() require("foldnav").goto_end() end },
      -- stylua: ignore end
    },
  },
  {
    "isakbm/gitgraph.nvim",
    lazy = true,
    opts = {
      -- symbols = {
      --   merge_commit = "M",
      --   commit = "*",
      -- },
      -- format = {
      --   timestamp = "%H:%M:%S %d-%m-%Y",
      --   fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      -- },
      symbols = {
        merge_commit = "",
        commit = "",
        merge_commit_end = "",
        commit_end = "",

        -- Advanced symbols
        GVER = "",
        GHOR = "",
        GCLD = "",
        GCRD = "╭",
        GCLU = "",
        GCRU = "",
        GLRU = "",
        GLRD = "",
        GLUD = "",
        GRUD = "",
        GFORKU = "",
        GFORKD = "",
        GRUDCD = "",
        GRUDCU = "",
        GLUDCD = "",
        GLUDCU = "",
        GLRDCL = "",
        GLRDCR = "",
        GLRUCL = "",
        GLRUCR = "",
      },
      hooks = {
        -- Check diff of a commit
        on_select_commit = function(commit)
          vim.notify("DiffviewOpen " .. commit.hash .. "^!")
          vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
          vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>ggl",
        function()
          require("gitgraph").draw({}, { max_count = 500 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = function()
      local function get_default_branch_name()
        local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
        return res.code == 0 and "main" or "master"
      end

      vim.keymap.set("n", "<leader>ggd", "<CMD>DiffviewOpen<CR>", { desc = "Diffview HEAD" })
      vim.keymap.set("n", "<leader>ggb", function()
        vim.cmd("DiffviewOpen " .. get_default_branch_name() .. "...HEAD")
      end, { desc = "Diffview master" })
      vim.keymap.set(
        "n",
        "<leader>gm",
        "<CMD>DiffviewFileHistory " .. get_default_branch_name() .. "...HEAD %<CR>",
        { desc = "Diffview File History master" }
      )
      vim.keymap.set("n", "<leader>gH", "<CMD>DiffviewFileHistory<CR>", { desc = "Diffview File History" })
      vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory --follow %<CR>", { desc = "Diffview File History" })
      vim.keymap.set(
        "v",
        "<leader>gh",
        "<Esc><CMD>'<,'>DiffviewFileHistory --follow<CR>",
        { desc = "Diffview Range History" }
      )
      vim.keymap.set("n", "<leader>gl", "<CMD>.DiffviewFileHistory --follow<CR>", { desc = "Diffview Line History" })
    end,
    opts = function(_, opts)
      local actions = require("diffview.actions")
      opts.enhanced_diff_hl = true
      opts.show_help_hints = false
      opts.hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = false
          vim.opt_local.foldenable = true
        end,
      }
      opts.view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      }
      opts.key_bindings = {
        file_history_panel = {
          ["<Space>"] = actions.toggle_fold, -- Toggle fold of the diff
          ["<M-w>"] = "<CMD>DiffviewClose<CR>",
        },
        file_panel = {
          ["<Space>"] = actions.toggle_fold, -- Toggle fold of the diff
          ["<M-w>"] = "<CMD>DiffviewClose<CR>",
        },
        view = {
          ["]D"] = actions.select_next_entry, -- Open the diff for the next file
          ["[D"] = actions.select_prev_entry, -- Open the diff for the previous file
          ["<Space>"] = actions.toggle_fold, -- Toggle fold of the diff
          ["<M-w>"] = "<CMD>DiffviewClose<CR>",
          ["<leader>ho"] = actions.conflict_choose("ours"),
          ["<leader>ht"] = actions.conflict_choose("theirs"),
          ["<leader>ha"] = actions.conflict_choose("all"),
          ["<leader>hm"] = actions.conflict_choose("base"),
          ["<leader>hn"] = actions.conflict_choose("none"),
        },
      }
    end,
  },
}
