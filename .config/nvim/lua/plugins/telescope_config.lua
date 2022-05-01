-- Config
local t = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

require("telescope").setup({
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    sorting_strategy = "ascending",
    scroll_strategy = nil,
    path_display = { "smart" },
    winblend = 9,
    file_ignore_patterns = { "messages.json$", "%.html$", "%.dump$", "%.svg$" },
    file_sorter = sorters.get_fzy_sorter,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-o>"] = t.builtin,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-o>"] = t.builtin,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
  },
  -- extensions = {
  --   dash = {
  --     fileTypeKeywords = {
  --       NvimTree = false,
  --       TelescopePrompt = false,
  --       terminal = false,
  --       packer = false,
  --       -- a table of strings will search on multiple keywords
  --       typescript = { "typescript", "javascript", "css", "html" },
  --       typescriptreact = { "typescript", "javascript", "react", "css", "html" },
  --       javascriptreact = { "javascript", "react", "css", "html" },
  --     },
  --   },
  -- },
})
require("telescope").load_extension("fzf")
-- require("telescope").load_extension("dap")

-- Functions
local changed_on_branch = function()
  pickers.new({
    results_title = "Modified on current branch",
    finder = finders.new_oneshot_job({
      "git",
      "diff",
      "--name-only",
      "--relative",
      "master",
    }),
    sorter = sorters.get_fuzzy_file(),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return { "git", "diff", "--relative", "master", entry.value }
      end,
    }),
  }):find()
end

local resume_or_builtin = function()
  local ok = pcall(t.resume)
  if not ok then
    t.builtin()
  end
end

local git_files_or_files = function()
  local ok = pcall(t.git_files)
  if not ok then
    t.find_files()
  end
end

-- Commands
vim.api.nvim_create_user_command("T", resume_or_builtin, {})
vim.api.nvim_create_user_command("F", git_files_or_files, {})
vim.api.nvim_create_user_command("TR", t.resume, {})
vim.api.nvim_create_user_command("S", t.git_status, {})
vim.api.nvim_create_user_command("H", t.oldfiles, {})
vim.api.nvim_create_user_command("RG", t.grep_string, {})
vim.api.nvim_create_user_command("RGG", t.live_grep, {})
vim.api.nvim_create_user_command("RGB", function()
  t.live_grep({ grep_open_files = true })
end, {})
vim.api.nvim_create_user_command("MB", changed_on_branch, {})

-- Mappings
vim.keymap.set("n", "<leader>tt", resume_or_builtin, { silent = true })
vim.keymap.set("n", "<leader>tf", git_files_or_files)
vim.keymap.set("n", "<leader>tr", t.resume)
vim.keymap.set("n", "<leader>ts", t.git_status)
vim.keymap.set("n", "<leader>td", changed_on_branch)
vim.keymap.set("n", "<leader>tg", t.live_grep)
vim.keymap.set("n", "<leader>tb", t.buffers)
vim.keymap.set("n", "<leader>th", t.oldfiles)
vim.keymap.set("n", "<leader>tm", t.marks)
vim.keymap.set("n", "<leader>tq", t.quickfix)
vim.keymap.set("n", "<leader>t:", t.commands)
