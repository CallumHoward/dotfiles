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
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
      tools = {
        claude = { cmd = { "~/.local/bin/claude" }, url = "https://github.com/anthropics/claude-code" },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "Code Companion Chat" },
      { "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Code Companion Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Code Companion Chat" },
    },
    cmd = { "Codecompanion", "CodeCompanionChat", "CodeCompanionActions", "CodecompanionCmd" },
    init = function()
      local spinner = require("plugins.extensions.codecompanion-spinner")
      spinner:init()
    end,
    opts = {
      memory = {
        chat = {
          enabled = true,
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "claude-sonnet-4.5",
            -- model = "claude-sonnet-4-5-20250929",
            -- model = "gpt-5",
          },
          opts = {
            goto_file_action = "tabnew",
          },
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd("stopinsert")
                chat:submit()
                chat:add_buf_message({ role = "llm", content = "" })
              end,
              index = 1,
              description = "Send",
            },
          },
          variables = {
            ["project"] = {
              ---@return string
              callback = "CLAUDE.md",
              description = "Claude project information",
              opts = {
                contains_code = true,
              },
            },
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
