-- Colorscheme config
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_sidebars = {
  "qf",
  "vista_kind",
  "Outline",
  "terminal",
  "packer",
  "help",
  "UltestSummary",
  "nofile",
}

-- vim-notify config
vim.notify = require("notify")

-- Scrollbar config
vim.cmd("let g:scrollview_column = 1")

-- Ultest config
vim.cmd("autocmd Filetype UltestSummary setl nowrap")
vim.g.ultest_pass_sign = "﫟"
vim.g.ultest_fail_sign = ""
vim.g.ultest_running_sign = "喇"
vim.g.ultest_not_run_sign = "ﱤ"
vim.cmd("nnoremap <leader>jn :UltestNearest<CR>")
vim.cmd("nnoremap <leader>ju :UltestSummary<CR>")
vim.cmd("nnoremap <leader>jf :Ultest<CR>")

-- Ranger config
vim.cmd("cabbrev ra <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ranger' : 'ra')<CR>")
vim.cmd("cabbrev va <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vs \\| Ranger' : 'ra')<CR>")
vim.cmd("cabbrev spa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'sp \\| Ranger' : 'ra')<CR>")
vim.cmd("cabbrev tra <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabe \\| Ranger' : 'ra')<CR>")

-- NvimTree
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 3
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 0,
}
vim.g.nvim_tree_icons = {
  default = "",
  diagnostics = {
    enable = true,
    icons = {
      error = "",
      warning = "",
      hint = "",
      info = "",
    },
  },
}
require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  disable_netrw = true,
  filters = {
    dotfiles = true,
  },
})

-- DiffView config
local cb = require("diffview.config").diffview_callback
require("diffview").setup({
  enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  hooks = {
    diff_buf_read = function()
      vim.opt_local.wrap = false
      vim.opt_local.foldenable = true
    end,
  },
  key_bindings = {
    view = {
      ["]D"] = cb("select_next_entry"), -- Open the diff for the next file
      ["[D"] = cb("select_prev_entry"), -- Open the diff for the previous file
    },
  },
})

-- Git linker config
local gl = require("gitlinker")
local gla = require("gitlinker.actions")
local function open_blame()
  gl.get_buf_range_url("n", {
    action_callback = gla.open_in_browser,
  })
end
gl.setup()
vim.keymap.set("n", "<leader>gb", open_blame)
vim.keymap.set("v", "<leader>gb", open_blame)

-- Symbols outline config
vim.g.symbols_outline = {
  auto_preview = false,
  position = "right",
  width = 16,
  show_symbol_details = true,
}
vim.api.nvim_exec([[ autocmd Filetype Outline setl nowrap ]], true)

-- null-ls config for nvim-lsp-ts-utils
local null_ls = require("null-ls")
local sources = {
  -- Handled in typescript-ls config
  -- null_ls.builtins.formatting.prettier,
  -- null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.diagnostics.write_good,
  -- null_ls.builtins.diagnostics.cspell,
  -- null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.shellcheck,
}
null_ls.setup({
  debug = false,
  sources = sources,
})

-- Lsp Signature
require("lsp_signature").setup({
  bind = true,
  hint_enable = false,
  handler_opts = {
    border = "none",
  },
  padding = " ",
})

-- Lightbulb
vim.cmd([[ autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb() ]])
vim.fn.sign_define("LightBulbSign", {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "",
  numhl = "DiagnosticSignWarn",
  priorioty = 12,
})

-- Trouble
require("trouble").setup({
  use_diagnostic_signs = true,
})

-- Testing
vim.cmd('let test#javascript#jest#options = "--color=always"')

-- vCooler config
vim.cmd("let g:vcoolor_disable_mappings = 1")
vim.cmd('let g:vcoolor_map = "<leader>jc"')

-- Hexokinase
vim.cmd(
  "let g:Hexokinase_ftEnabled = ['css', 'html', 'scss', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'handlebars', 'vim', 'conf']"
)

-- bufjump config
local bj = require("bufjump")
vim.keymap.set("n", "<M-o>", bj.backward)
vim.keymap.set("n", "<M-i>", bj.forward)

-- nvim-autopairs
require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

-- Import cost config
vim.api.nvim_exec(
  [[
    augroup ImportCostAutogroup
      autocmd!
      autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx silent ImportCost
    augroup END
  ]],
  true
)

-- Package info config
local pi = require("package-info")
pi.setup({
  colors = {
    up_to_date = "#565f89", -- Text color for up to date package virtual text
    outdated = "#e0af68", -- Text color for outdated package virtual text
  },
})
vim.keymap.set("n", "<leader>ns", pi.show) -- Show package versions
vim.keymap.set("n", "<leader>nc", pi.hide) -- Hide package versions
vim.keymap.set("n", "<leader>nu", pi.update) -- Update package on line
vim.keymap.set("n", "<leader>nd", pi.delete) -- Delete package on line
vim.keymap.set("n", "<leader>ni", pi.install) -- Install a new package
vim.keymap.set("n", "<leader>nr", pi.reinstall) -- Reinstall dependencies
-- vim.keymap.set("n", "<leader>np", pi.changeversion) -- Install a different package version

-- Debug
-- require("dapui").setup()

-- -- Configure all installed debuggers
-- local dap_install = require("dap-install")

-- local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
-- for _, debugger in ipairs(dbg_list) do
--   dap_install.config(debugger)
-- end

-- AsyncDo
vim.cmd([[command! -bang -nargs=* -complete=file Make call asyncdo#run(<bang>0, &makeprg, <f-args>)]])
