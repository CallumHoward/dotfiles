local prettier_config = {
  function()
    return {
      exe = "npx prettier",
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

local flutter_config = {
  function()
    return {
      exe = "flutter format",
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
    dart = flutter_config,
  },
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("FormatterAutogroup", {}),
  pattern = { "*.lua", "*.cpp", "*.hpp", "*.c", "*.h", "*.go", "*.swift", "*.tsx", "*.ts", "*.svelte", "*.dart" },
  command = "FormatWrite",
})
