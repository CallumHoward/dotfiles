return {
  { "mustache/vim-mustache-handlebars", ft = { "handlebars", "mustache" } },
  { "kchmck/vim-coffee-script", ft = { "coffee" } },
  { "rhysd/vim-syntax-codeowners", ft = "codeowners" },
  -- { "norcalli/nvim-terminal.lua", opts = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "svelte",
        "css",
        "styled",
        "ssh_config",
        "tmux",
        "editorconfig",
      })
    end,
  },
  {
    "m00qek/baleia.nvim",
    cmd = { "BaleiaColorize" },
    config = function()
      local baleia
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        if not baleia then
          baleia = require("baleia").setup({})
        end
        baleia.once(vim.api.nvim_get_current_buf())
      end, {})
    end,
  },
}
