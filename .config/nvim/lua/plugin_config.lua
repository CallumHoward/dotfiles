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
require("compe_config")
-- vim.cmd('if g:compe then let g:compe.source.tabnine = v:true fi')

-- DiffView config
local cb = require("diffview.config").diffview_callback
require("diffview").setup({
  enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
  signs = {
    fold_closed = "",
    fold_open = "",
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
  -- null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.shellcheck,
}
null_ls.config({
  debug = false,
  sources = sources,
})
require("lspconfig")["null-ls"].setup({})

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
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
vim.fn.sign_define("LightBulbSign", {
  text = "",
  texthl = "LspDiagnosticsDefaultWarning",
  linehl = "",
  numhl = "LspDiagnosticsDefaultWarning",
  priorioty = 12,
})

-- Trouble
require("trouble").setup({
  use_lsp_diagnostic_signs = true,
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

require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = false, -- auto select first item
  map_char = { -- modifies the function or method delimiter by filetypes
    all = "(",
    tex = "{",
  },
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
vim.cmd(
  [[ call wilder#set_option('renderer', wilder#popupmenu_renderer({ 'highlighter': wilder#basic_highlighter(), 'left': [' ', wilder#popupmenu_devicons()], 'right': [' ', wilder#popupmenu_scrollbar()]})) ]]
)
