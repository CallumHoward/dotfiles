local opts = {
  settings = {
    json = {
      schemas = {
        {
          description = "NPM Package configuration",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "TypeScript compiler configuration file",
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "http://json.schemastore.org/tsconfig",
        },
        {
          description = "Lerna config",
          fileMatch = { "lerna.json" },
          url = "http://json.schemastore.org/lerna",
        },
        {
          description = "Babel configuration",
          fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
          url = "http://json.schemastore.org/lerna",
        },
        {
          description = "ESLint config",
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "http://json.schemastore.org/eslintrc",
        },
        {
          description = "Bucklescript config",
          fileMatch = { "bsconfig.json" },
          url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json",
        },
        {
          description = "Prettier config",
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "http://json.schemastore.org/prettierrc",
        },
        {
          description = "Vercel Now config",
          fileMatch = { "now.json" },
          url = "http://json.schemastore.org/now",
        },
        {
          description = "Stylelint config",
          fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
          url = "http://json.schemastore.org/stylelintrc",
        },
      },
    },
  },
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("jsonls")

if server_available then
  requested_server:on_ready(function()
    requested_server:setup(opts)
  end)
end
