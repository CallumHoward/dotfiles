return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = { "hrsh7th/cmp-emoji" },
    event = "InsertEnter",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["{"] = function(fallback)
          cmp.close()
          fallback()
        end,
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }
    end,
  },
  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     sources = {
  --       providers = {
  --         lsp = {
  --           -- enabled = false,
  --           async = true,
  --           timeout_ms = 200,
  --           min_keyword_length = 3,
  --         },
  --       },
  --     },
  --   },
  -- config = function(_, opts)
  --   opts.sources.providers.lsp.async = function()
  --     local clients = vim.lsp.get_clients({ bufnr = 0 })
  --     for _, client in ipairs(clients) do
  --       if client.name == "vtsls" then
  --         return true
  --       end
  --       return false
  --     end
  --   end
  -- end,
  -- },
}
