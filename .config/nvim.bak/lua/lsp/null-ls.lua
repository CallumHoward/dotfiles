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
