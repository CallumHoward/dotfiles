local map_opts = { silent = true, noremap = true }

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

-- Indent guides config
vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class",
  "function",
  "method",
  "block",
  "list_literal",
  "selector",
  "^if",
  "^table",
  "if_statement",
  "while",
  "for",
  "arguments",
  "switch_statement",
  "switch_case",
  "switch_default",
  "jsx_element",
  "open_tag",
  "object",
  "object_type",
  "parenthesized_expression",
  "jsx_self_closing_element",
}
vim.g.indent_blankline_context_highlight_list = { "NonText" }
vim.g.indent_blankline_buftype_exclude = { "nofile", "terminal" }
vim.g.indent_blankline_filetype_exclude = { "qf", "vista_kind", "terminal", "packer", "help", "UltestSummary" }

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
vim.g.nvim_tree_indent_markers = 1
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
  tree_follow = true,
  disable_netrw = true,
  nvim_tree_ignore = { ".git", "node_modules" },
  nvim_tree_gitignore = true,
})

-- Completion
require("cmp_config")

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
require("gitlinker").setup()
vim.api.nvim_set_keymap(
  "n",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true }
)

-- Symbols outline config
vim.g.symbols_outline = {
  auto_preview = false,
  position = "right",
  width = 16,
  show_symbol_details = true,
}
vim.api.nvim_exec([[ autocmd Filetype Outline setl nowrap ]], true)

-- Git signs config
require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  preview_config = { border = "none" },
  current_line_blame = true,
  current_line_blame_formatter_opts = { relative_time = true },
  current_line_blame_formatter = function(name, blame_info, opts)
    if blame_info.author == name then
      blame_info.author = "You"
    end

    local text
    if blame_info.author == "Not Committed Yet" then
      text = "    You, a while ago • Uncommitted changes"
    else
      local date_time

      if opts.relative_time then
        date_time = require("gitsigns.util").get_relative_time(tonumber(blame_info["author_time"]))
      else
        date_time = os.date("%Y-%m-%d", tonumber(blame_info["author_time"]))
      end

      text = string.format("    %s, %s • %s", blame_info.author, date_time, blame_info.summary)
    end

    return { { " " .. text, "GitSignsCurrentLineBlame" } }
  end,
})
vim.api.nvim_set_keymap("n", "<leader>ggm", "<cmd>lua require('gitsigns').change_base('master', true)<CR>", map_opts)
vim.api.nvim_set_keymap("n", "<leader>ggh", "<cmd>lua require('gitsigns').change_base('HEAD', true)<CR>", map_opts)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gg",
  "<cmd>lua require('gitsigns').change_base('HEAD~', true)<Left><Left><Left><Left><Left><Left><Left><Left>",
  map_opts
)
vim.api.nvim_set_keymap("n", "<leader>hl", "<cmd>Gitsigns setqflist<CR>", map_opts)

-- Telescope
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
require("telescope").setup({
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    sorting_strategy = "ascending",
    scroll_strategy = nil,
    path_display = { "smart" },
    winblend = 9,
    file_ignore_patterns = { "messages.json$", "%.html$" },
    file_sorter = sorters.get_fzy_sorter,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})
require("telescope").load_extension("fzf")

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

-- Formatter
local prettier_config = {
  function()
    return {
      exe = "prettier",
      args = {
        "--stdin",
        "--stdin-filepath",
        vim.api.nvim_buf_get_name(0),
        "--arrow-parens=always",
        "--plugin-search-dir=.",
      },
      stdin = true,
    }
  end,
}

local clang_format_config = {
  function()
    return {
      exe = "clang-format",
      args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
      stdin = true,
      cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
    }
  end,
}

local stylua_config = {
  function()
    return {
      exe = "stylua",
      args = {
        "--config-path " .. os.getenv("HOME") .. "/.config/stylua/stylua.toml",
        "-",
      },
      stdin = true,
    }
  end,
}

local gofmt_config = {
  function()
    return {
      exe = "gofmt",
      stdin = true,
    }
  end,
}

local swift_format_config = {
  function()
    return {
      exe = "swift format",
      stdin = true,
    }
  end,
}

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = prettier_config,
    typescript = prettier_config,
    javascriptreact = prettier_config,
    typescriptreact = prettier_config,
    svelte = prettier_config,
    vue = prettier_config,
    html = prettier_config,
    css = prettier_config,
    scss = prettier_config,
    less = prettier_config,
    json = prettier_config,
    markdown = prettier_config,
    lua = stylua_config,
    cpp = clang_format_config,
    c = clang_format_config,
    go = gofmt_config,
    swift = swift_format_config,
  },
})

vim.api.nvim_exec(
  [[
     augroup FormatAutogroup
       autocmd!
       autocmd BufWritePost *.lua,*.cpp,*.hpp,*.c,*.h,*.go,*.swift silent FormatWrite
     augroup END
   ]],
  true
)

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
vim.api.nvim_set_keymap("n", "<M-o>", "<cmd>lua require('bufjump').backward()<CR>", map_opts)
vim.api.nvim_set_keymap("n", "<M-i>", "<cmd>lua require('bufjump').forward()<CR>", map_opts)

-- nvim-ts-context-commentstring config
require("nvim-treesitter.configs").setup({
  context_commentstring = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})

-- nvim-autopairs
require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

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
require("package-info").setup({
  colors = {
    up_to_date = "#565f89", -- Text color for up to date package virtual text
    outdated = "#e0af68", -- Text color for outdated package virtual text
  },
})
-- Show package versions
vim.api.nvim_set_keymap("n", "<leader>ns", ":lua require('package-info').show()<CR>", { silent = true, noremap = true })
-- Hide package versions
vim.api.nvim_set_keymap("n", "<leader>nc", ":lua require('package-info').hide()<CR>", { silent = true, noremap = true })
-- Update package on line
vim.api.nvim_set_keymap(
  "n",
  "<leader>nu",
  ":lua require('package-info').update()<CR>",
  { silent = true, noremap = true }
)
-- Delete package on line
vim.api.nvim_set_keymap(
  "n",
  "<leader>nd",
  ":lua require('package-info').delete()<CR>",
  { silent = true, noremap = true }
)
-- Install a new package
vim.api.nvim_set_keymap(
  "n",
  "<leader>ni",
  ":lua require('package-info').install()<CR>",
  { silent = true, noremap = true }
)
-- Reinstall dependencies
vim.api.nvim_set_keymap(
  "n",
  "<leader>nr",
  ":lua require('package-info').reinstall()<CR>",
  { silent = true, noremap = true }
)
-- Install a different package version
vim.api.nvim_set_keymap(
  "n",
  "<leader>np",
  ":lua require('package-info').changeversion()<CR>",
  { silent = true, noremap = true }
)

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
