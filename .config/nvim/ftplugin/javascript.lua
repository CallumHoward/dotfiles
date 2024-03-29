vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- Console logging mappings

vim.keymap.set(
  "n",
  "<leader>jl",
  'yiwoconsole.log("LOG <C-R>"");<Esc>',
  { buffer = true, desc = "Add log for word under cursor (after)" }
)
vim.keymap.set(
  "x",
  "<leader>jl",
  'yoconsole.log("LOG <C-R>"");<Esc>',
  { buffer = true, desc = "Add log for selection (after)" }
)
vim.keymap.set(
  "n",
  "<leader>jL",
  'yiwOconsole.log("LOG <C-R>"");<Esc>',
  { buffer = true, desc = "Add log for word under cursor (before)" }
)
vim.keymap.set(
  "x",
  "<leader>jL",
  'yOconsole.log("LOG <C-R>"");<Esc>',
  { buffer = true, desc = "Add log for selection (before)" }
)

local function log_stage(number)
  local log_text = string.format("LOG Stage %d: %s:%d", number, vim.fn.expand("%:t"), vim.fn.line(".") + 1)
  vim.fn.append(vim.fn.line("."), 'console.log("' .. log_text .. '");')
  vim.api.nvim_feedkeys("j==", "n", true)
end

for stage = 1, 9 do
  local mapping = string.format("<leader>j%d", stage)
  vim.keymap.set("n", mapping, function()
    log_stage(stage)
  end, { buffer = true, desc = "which_key_ignore" })
end

-- Test mappings
vim.keymap.set("n", "<leader>jo", function()
  local minianimate_disable = vim.b.minianimate_disable
  vim.b.minianimate_disable = true

  -- Create a jump point
  vim.cmd("norm m'$")

  vim.fn.search("\\<\\(it\\|describe\\|test\\)\\>\\ze(", "be")
  vim.api.nvim_put({ ".only" }, "c", true, true)

  vim.b.minianimate_disable = minianimate_disable
end, { buffer = true, desc = "Add .only to current test case" })

vim.keymap.set("n", "<leader>jO", function()
  local minianimate_disable = vim.b.minianimate_disable
  vim.b.minianimate_disable = true

  -- Create a jump point
  vim.cmd("norm m'$")

  local only_pattern = "\\.only\\>\\ze("
  vim.fn.search(only_pattern, "b")

  local current_line_num = vim.fn.line(".")
  local current_line = vim.fn.getline(current_line_num)
  local updated_line = vim.fn.substitute(current_line, only_pattern, "", "")
  vim.fn.setline(current_line_num, updated_line)

  vim.b.minianimate_disable = minianimate_disable
end, { buffer = true, desc = "Remove .only from current test case" })

vim.keymap.set("n", "<leader>js", function()
  local minianimate_disable = vim.b.minianimate_disable
  vim.b.minianimate_disable = true

  -- Create a jump point
  vim.cmd("norm m'$")

  vim.fn.search("\\<\\(it\\|describe\\|test\\)\\>\\ze(", "be")
  vim.api.nvim_put({ ".skip" }, "c", true, true)

  vim.b.minianimate_disable = minianimate_disable
end, { buffer = true, desc = "Add .skip to current test case" })

vim.keymap.set("n", "<leader>jS", function()
  local minianimate_disable = vim.b.minianimate_disable
  vim.b.minianimate_disable = true

  -- Create a jump point
  vim.cmd("norm m'$")

  local only_pattern = "\\.skip\\>\\ze("
  vim.fn.search(only_pattern, "b")

  local current_line_num = vim.fn.line(".")
  local current_line = vim.fn.getline(current_line_num)
  local updated_line = vim.fn.substitute(current_line, only_pattern, "", "")
  vim.fn.setline(current_line_num, updated_line)

  vim.b.minianimate_disable = minianimate_disable
end, { buffer = true, desc = "Remove .skip from current test case" })

-- Compiler mappings
vim.keymap.set("n", "<leader>jt", ":comp tsc | Make<CR>", { buffer = true, desc = "Compile tsc (async)" })
vim.keymap.set("n", "<leader>je", ":comp eslint | Make<CR>", { buffer = true, desc = "Compile eslint (async)" })
