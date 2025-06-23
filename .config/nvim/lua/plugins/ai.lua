return {
  {
    "ravitemer/mcphub.nvim",
    lazy = true,
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Code Companion Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Code Companion Chat" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "claude-sonnet-4",
          },
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      { "<leader>aa", false },
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
          require("CopilotChat.select_prompt").pick(actions.help_actions())
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Help actions",
      },
    },
  },
}
