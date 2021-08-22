-- Colorscheme config
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "help", "UltestSummary" }

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
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_highlight_opened_files = 3
vim.cmd("let g:nvim_tree_show_icons = { 'git': 0, 'folders': 1, 'files': 1 }")

-- Completion
require("compe_config")
-- vim.cmd('if g:compe then let g:compe.source.tabnine = v:true fi')

-- Git linker config
require("gitlinker").setup()

-- Vista config
vim.g.vista_default_executive = "nvim_lsp"
vim.g.vista_sidebar_width = 30
vim.g.vista_highlight_whole_line = 1
vim.g.vista_echo_cursor_strategy = "floating_win"

-- Git signs config
require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  current_line_blame = true,
  current_line_blame_formatter_opts = { relative_time = true },
  current_line_blame_formatter = function(name, blame_info, opts)
    if blame_info.author == name then
      blame_info.author = "You"
    end

    local text
    if blame_info.author == "Not Committed Yet" then
      text = "You, a while ago • Uncommitted changes"
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
    -- shorten_path = true,
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
})

-- Trouble
require("trouble").setup({
  use_lsp_diagnostic_signs = true,
})

-- Formatter
local prettier_config = {
  -- prettier
  function()
    return {
      exe = "prettier_d_slim",
      args = { "--stdin", "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
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
    vue = prettier_config,
    html = prettier_config,
    css = prettier_config,
    scss = prettier_config,
    less = prettier_config,
    json = prettier_config,
    markdown = prettier_config,
    lua = {
      -- stylua
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
    },
  },
})

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx,*.lua FormatWrite
augroup END
]],
  true
)

-- Which-key
-- require('which-key').setup {
--   triggers_blacklist = {
--     i = { '{' }
--   }
-- }

-- Formatting
--require('lv-utils')
vim.cmd('command! LspFormatting lua require("lv-utils").formatting()')

-- Testing
vim.cmd('let test#javascript#jest#options = "--color=always"')

-- vCooler config
vim.cmd("let g:vcoolor_disable_mappings = 1")
vim.cmd('let g:vcoolor_map = "<leader>jc"')
