return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "yaml",
        "css",
        "scss",
        "html",
        "markdown",
      }) do
        opts.formatters_by_ft[ft] = { "prettier", "trim_newlines" }
      end
      return opts
    end,
  },
}
