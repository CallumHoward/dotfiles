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
    -- Pinned to fix branch until PR #594 merges (nvim 0.12 treesitter iter_matches compat)
    -- TODO: revert to "nvim-neotest/neotest" once https://github.com/nvim-neotest/neotest/pull/594 is merged
    "LiamCoop/neotest",
    branch = "fix/590-treesitter-iter-matches-breaking-change",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
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
      opts.adapters = opts.adapters or {}
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
      local vitest = require("neotest-vitest")({
        vitestConfigFile = function(path)
          local custom = vim.fn.findfile("vitest.unit.config.ts", path .. ";")
          if custom ~= "" then
            return custom
          end
          return vim.fn.findfile("vitest.config.ts", path .. ";")
        end,
      })
      -- neotest-vitest wraps lib.files.read (nio async) in pcall inside
      -- hasVitestDependency. LuaJIT cannot yield across a C-level pcall
      -- boundary, so the yield attempt is caught as an error and
      -- is_test_file always returns false. Fix: use sync IO instead.
      vitest.is_test_file = function(file_path)
        if not file_path then
          return false
        end
        local is_test = file_path:match("__tests__") ~= nil
        for _, pat in ipairs({ "e2e", "spec", "test" }) do
          for _, ext in ipairs({ "js", "jsx", "coffee", "ts", "tsx" }) do
            if file_path:match("%." .. pat .. "%." .. ext .. "$") then
              is_test = true
              break
            end
          end
          if is_test then
            break
          end
        end
        if not is_test then
          return false
        end
        local pkg = vim.fs.find("package.json", { path = vim.fs.dirname(file_path), upward = true })[1]
        if not pkg then
          return false
        end
        local lines = vim.fn.readfile(pkg)
        local content = table.concat(lines, "")
        return content:find('"vitest"') ~= nil or content:find('"@vitest/') ~= nil
      end
      table.insert(opts.adapters, vitest)
      table.insert(opts.adapters, require("neotest-go")({}))

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
