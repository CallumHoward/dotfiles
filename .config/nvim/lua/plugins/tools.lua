return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "markdown.mdx" },
    lazy = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown", "markdown.mdx" }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      {
        "<leader>ch",
        function()
          local chat = require("CopilotChat")
          chat.toggle()
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Toggle",
      },
      {
        "<leader>tch",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "<leader>tcp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Prompt actions",
      },
    },
  },
  {
    "pwntester/octo.nvim",
    keys = {
      {
        "<leader>go",
        "<cmd>Octo<cr>",
        { desc = "Octo" },
      },
    },
  },
}
