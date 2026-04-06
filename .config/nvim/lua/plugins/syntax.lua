return {
  { "mustache/vim-mustache-handlebars", ft = { "handlebars", "mustache" } },
  { "kchmck/vim-coffee-script", ft = { "coffee" } },
  { "rhysd/vim-syntax-codeowners", ft = "codeowners" },
  -- { "norcalli/nvim-terminal.lua", opts = true },
  {
    -- Remove ]c/[c treesitter class mappings — conflict with gitsigns hunk navigation
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = function(_, opts)
      opts.move.keys.goto_next_start["]c"] = nil
      opts.move.keys.goto_previous_start["[c"] = nil
      return opts
    end,
  },
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
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
    keys = {
      { "zT", "<cmd>TailwindFoldToggle<cr>", desc = "Toggle class folding" },
    },
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
