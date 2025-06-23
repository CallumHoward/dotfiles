return {
  {
    "saghen/blink.cmp",
    dependencies = { "mgalliou/blink-cmp-tmux" },
    opts = {
      sources = {
        default = { "tmux" },
        providers = {
          tmux = {
            module = "blink-cmp-tmux",
            name = "tmux",
            -- default options
            opts = {
              all_panes = false,
              capture_history = false,
              -- only suggest completions from `tmux` if the `trigger_chars` are
              -- used
              triggered_only = false,
              trigger_chars = { "." },
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "alexandre-abrioux/blink-cmp-npm.nvim" },
    opts = {
      sources = {
        default = { "npm" },
        providers = {
          -- configure the provider
          npm = {
            name = "npm",
            module = "blink-cmp-npm",
            async = true,
            -- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
            score_offset = 100,
            -- optional - blink-cmp-npm config
            ---@module "blink-cmp-npm"
            ---@type blink-cmp-npm.Options
            opts = {
              ignore = {},
              only_semantic_versions = true,
              only_latest_version = false,
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "moyiz/blink-emoji.nvim",
    },
    opts = {
      sources = {
        default = { "emoji" },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- Tune by preference
            opts = {
              insert = true, -- Insert emoji (default) or complete its name
              ---@type string|table|fun():table
              trigger = function()
                return { ":" }
              end,
            },
          },
        },
      },
    },
  },
}
