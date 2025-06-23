return {
  {
    "hauleth/asyncdo.vim",
    cmd = "Make",
    config = function()
      vim.cmd([[command! -bang -nargs=* -complete=file Make call asyncdo#run(<bang>0, &makeprg, <f-args>)]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local spinners = { "", "", "" }
          return vim.fn.exists("g:asyncdo") ~= 0 and spinners[(vim.fn.localtime() % #spinners) + 1] or ""
        end,
        -- color = Snacks.util.color("Constant"),
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
    },
    -- stylua: ignore
    keys = {
      { "<leader>ju", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>jd", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>jn", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>jf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    },
    opts = function(_, opts)
      opts.summary = {
        mappings = {
          expand = { "l", "zo", "za" },
          expand_all = { "e", "zO" },
          mark = { "<Tab>", "m", "<Space>" },
          jumpto = { "i", "<CR>", "<2-LeftMouse>" },
        },
      }
      opts.discovery = { enabled = false }
      opts.quickfix = { open = false }
      opts.output = { open_on_run = false }
      opts.icons = {
        child_indent = " ",
        child_prefix = " ",
        expanded = " ",
        final_child_prefix = " ",
        collapsed = " ",
        non_collapsible = " ",
        running_animated = { "◴", "◷", "◶", "◵" },
        passed = "",
        failed = "",
        running = "",
        skipped = "",
        unknown = "",
      }
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jest_test_discovery = false,
        })
      )
    end,
    config = function(_, opts)
      vim.cmd("autocmd Filetype neotest-summary setl nowrap")

      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup(opts)
    end,
  },
}
