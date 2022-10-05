-- Neotest config
require("neotest").setup({
  discovery = {
    enabled = false,
  },
  summary = {
    mappings = {
      expand = { "l", "zo", "za" },
      expand_all = { "e", "zO" },
      mark = { "<Tab>", "m", "<Space>" },
      jumpto = { "i", "<CR>", "<2-LeftMouse>" },
    },
  },
  output = {
    open_on_run = false,
  },
  icons = {
    child_indent = " ",
    child_prefix = " ",
    expanded = " ",
    final_child_prefix = " ",
    collapsed = " ",
    non_collapsible = " ",
    running_animated = { "◴", "◷", "◶", "◵" },
    passed = "",
    failed = "",
    running = "",
    skipped = "",
    unknown = "",
  },
  adapters = {
    require("neotest-jest")({
      jestCommand = "npm test --",
      -- jestConfigFile = "custom.jest.config.ts",
      -- env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
    require("neotest-go"),
  },
})

vim.cmd("autocmd Filetype neotest-summary setl nowrap")

vim.keymap.set("n", "<leader>ju", require("neotest").summary.toggle)
vim.keymap.set("n", "<leader>jn", require("neotest").run.run)
vim.keymap.set("n", "<leader>jf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end)
