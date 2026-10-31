return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "markdown.mdx" },
    lazy = true,
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" }, wanted = false })
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown", "markdown.mdx" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters["markdownlint-cli2"].args = {
        '--config="~/.markdownlint-cli2.jsonc"',
      }
    end,
  },
}
