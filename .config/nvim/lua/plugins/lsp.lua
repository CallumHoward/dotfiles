return {
  {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable("copilot_ls")

      vim.keymap.set("n", "<CR>", function()
        -- Try to jump to the start of the suggestion edit.
        -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
        local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
          or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
          or vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
      end, { desc = "Clear Copilot suggestion or fallback" })

      vim.keymap.set("n", "<esc>", function()
        if not require("copilot-lsp.nes").clear() then
          -- fallback to other functionality
          Snacks.notifier.hide()
          vim.cmd("nohlsearch")
        end
      end)
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    lazy = true,
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   opts = {
  --     settings = {
  --       expose_as_code_action = "all",
  --       tsserver_file_preferences = {
  --         includeInlayParameterNameHints = "literals",
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = false,
  --         includeInlayPropertyDeclarationTypeHints = false,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = false,
  --         includeCompletionsForModuleExports = true,
  --         importModuleSpecifierEnding = "minimal",
  --         quotePreference = "double",
  --       },
  --       complete_function_calls = true,
  --       tsserver_plugins = {
  --         -- for TypeScript v4.9+
  --         "@styled/typescript-styled-plugin",
  --         -- or for older TypeScript versions
  --         -- "typescript-styled-plugin",
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "neovim/nvim-lspconfig",
  --       opts = {
  --         -- make sure mason installs the server
  --         servers = {
  --           tsserver = {
  --             enabled = false,
  --           },
  --           -- denols = {},
  --         },
  --       },
  --     },
  --   },
  --   event = "VeryLazy",
  -- },
  {
    "OlegGulevskyy/better-ts-errors.nvim",
    lazy = true,
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = {
      keymaps = {
        toggle = "<leader>cD",
        go_to_definition = "<leader>gD",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      format = {
        async = true,
      },
      --@type lspconfig.options
      inlay_hints = { enabled = false },
      keys = {
        { "<leader>co", false },
      },
      servers = {
        coffeesense = {
          filetypes = { "coffee" },
        },
        vtsls = {
          keys = {
            { "<leader>cD", false },
          },
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 4096,
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCalls = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- tsserver = function(_, opts)
        --   opts.capabilities.documentFormattingProvider = false
        --   require("lazyvim.util").lsp.on_attach(function(client, buffer)
        --     if client.name == "typescript-tools" then
        --       vim.keymap.set("n", "gd", "<cmd>TSToolsGoToSourceDefinition<CR>")
        --       -- stylua: ignore
        --       -- vim.keymap.set("n", "<leader>co", "<cmd>TSToolsOrganizeImports<CR>",
        --         -- { buffer = buffer, desc = "Organize Imports" })
        --       -- stylua: ignore
        --       vim.keymap.set("n", "<leader>cR", "<cmd>TSToolsRenameFile<CR>", { desc = "Rename File", buffer = buffer })
        --     end
        --   end)
        --   -- require("typescript").setup({ server = opts })
        --   return true
        -- end,
        htmx = function(_, opts)
          opts.autostart = false
        end,
        eslint = function(_, opts)
          opts.capabilities.documentFormattingProvider = true
        end, -- example to setup with typescript.nvim
        emmet = function(_, opts)
          opts.autostart = false
          opts.capabilities.textDocument.completion.completionItem.snippetSupport = false
        end,
        tailwindcss = function(_, opts)
          opts.autostart = false
        end,
        coffeesense = function(_, opts)
          require("lspconfig").coffeesense.setup({ server = opts })
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
