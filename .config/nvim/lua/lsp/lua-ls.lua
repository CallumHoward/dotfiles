require("lspconfig").lua.setup({
  cmd = {
    DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
    "-E",
    DATA_PATH .. "/lspinstall/lua/main.lua",
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        maxPreload = 100000,
        preloadFileSize = 1000,
      },
    },
  },
})
