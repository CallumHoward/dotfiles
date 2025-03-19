return {
  -- {
  --   "zeioth/garbage-day.nvim",
  --   dependencies = "neovim/nvim-lspconfig",
  --   event = "VeryLazy",
  -- },
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
    event = "VeryLazy",
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
        emmet_ls = {
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "javascript",
            "typescript",
            "markdown",
            "ejs",
            "svelte",
          },
        },
        vtsls = {
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
