local Util = require("lazyvim.util")

-- Commands
-- vim.api.nvim_create_user_command("T", resume_or_builtin, {})
-- vim.api.nvim_create_user_command("F", git_files_or_files, {})
-- vim.api.nvim_create_user_command("TR", t.resume, {})
-- vim.api.nvim_create_user_command("S", t.git_status, {})
-- vim.api.nvim_create_user_command("H", t.oldfiles, {})
-- vim.api.nvim_create_user_command("B", t.buffers, {})
-- vim.api.nvim_create_user_command("RG", t.grep_string, {})
-- vim.api.nvim_create_user_command("RGG", t.live_grep, {})
-- vim.api.nvim_create_user_command("RGD", extensions.dir.live_grep, {})
-- vim.api.nvim_create_user_command("RGB", function()
--   t.live_grep({ grep_open_files = true })
-- end, {})
-- vim.api.nvim_create_user_command("MB", changed_on_branch, {})

return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    -- dependencies = {
    --   "nvim-telescope/telescope-fzf-native.nvim",
    --   build = "make",
    --   config = function()
    --     require("telescope").load_extension("fzf")
    --   end,
    -- },
    keys = function()
      -- local extensions = require("telescope").extensions

      -- Functions
      local changed_on_branch = function()
        local pickers = require("telescope.pickers")
        pickers
          .new({
            results_title = "Modified on current branch",
            finder = require("telescope.finders").new_oneshot_job({
              "git",
              "diff",
              "--name-only",
              "--relative",
              "master",
            }, {}),
            sorter = require("telescope.sorters").get_fuzzy_file(),
            previewer = require("telescope.previewers").new_termopen_previewer({
              get_command = function(entry)
                return { "git", "diff", "--relative", "master", entry.value }
              end,
            }),
          }, {})
          :find()
      end

      local resume_or_builtin = function()
        local cached_pickers = require("telescope.state").get_global_key("cached_pickers")
        if cached_pickers == nil or vim.tbl_isempty(cached_pickers) then
          Util.pick("builtin")
        else
          Util.pick("resume")
        end
      end

      local in_buffer_dir = function(builtin)
        return function()
          return Util.pick(builtin, { cwd = require("telescope.utils").buffer_dir() })()
        end
      end

      return {
        { "<leader>tt", resume_or_builtin(), desc = "Telescope" },
        { "<leader>tff", Util.pick("files", { root = false }), desc = "Files" },
        { "<leader>tfF", Util.pick("files"), desc = "Files (calc root)" },
        { "<leader>tfd", in_buffer_dir("files"), desc = "Files (buffer dir)" },
        { "<leader>tr", Util.pick("resume"), desc = "Resume" },
        { "<leader>ts", Util.pick("git_status"), desc = "Git Status" },
        { "<leader>td", changed_on_branch, desc = "Git Changed On Branch" },
        { "<leader>tgf", Util.pick("grep_string", { root = false }), desc = "Grep (fuzzy)" },
        { "<leader>tgF", Util.pick("grep_string"), desc = "Grep Fuzzy (calc root)" },
        { "<leader>tgg", Util.pick("live_grep", { root = false }), desc = "Grep" },
        { "<leader>tgG", Util.pick("live_grep"), desc = "Grep (calc root)" },
        { "<leader>tgd", in_buffer_dir("live_grep"), desc = "Grep (buffer dir)" },
        { "<leader>tgb", Util.pick("live_grep", { grep_open_files = true }), desc = "Grep Buffers" },
        { "<leader>tgm", Util.pick("live_grep", { grep_open_files = true }), desc = "Grep Changed Since Master" },
        { "<leader>tgh", Util.pick("live_grep", { grep_open_files = true }), desc = "Grep Changed Since HEAD" },
        { "<leader>tb", Util.pick("buffers"), desc = "Buffers" },
        { "<leader>th", Util.pick("oldfiles"), desc = "History" },
        { "<leader>tH", Util.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "History (cwd)" },
        { "<leader>tm", Util.pick("marks"), desc = "Marks" },
        { "<leader>tq", Util.pick("quickfix"), desc = "Quickfix" },
        { "<leader>t:", Util.pick("commands"), desc = "Commands" },
        { "<leader>t@", Util.pick("lsp_dynamic_workspace_symbols"), desc = "Symbols" },
      }
    end,
    opts = function(_, opts)
      local tel = require("telescope")
      local t = require("telescope.builtin")
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")
      local custom_pickers = require("j.telescope_custom_pickers")
      local open_with_trouble = require("trouble.sources.telescope").open

      opts.defaults = {
        layout_config = {
          prompt_position = "top",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
          "--hidden",
          "--glob=!{.git,yarn.lock,*.log,messages.json}",
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        sorting_strategy = "ascending",
        scroll_strategy = nil,
        -- path_display = { truncate = 3 },
        path_display = { "smart" },
        winblend = 9,
        dynamic_preview_title = true,
        file_ignore_patterns = { "messages.json$", "%.html$", "%.dump$", "%.svg$", "%.snap$" },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<M-o>"] = t.builtin,
            ["<C-r>"] = open_with_trouble,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
          n = {
            ["<esc>"] = actions.close,
            ["<C-c>"] = actions.close,
            ["<C-r>"] = open_with_trouble,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<M-o>"] = t.builtin,
            ["<C-u>"] = actions.results_scrolling_up,
            ["<C-d>"] = actions.results_scrolling_down,
          },
        },
      }

      opts.pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
        },
        git_status = {
          git_icons = {
            added = "+",
            changed = "~",
            copied = "",
            deleted = "-",
            renamed = ">",
            unmerged = "^",
            untracked = "?",
          },
        },
        live_grep = {
          -- path_display = { "shorten" },
          mappings = {
            i = {
              ["<c-f>"] = custom_pickers.actions.set_extension,
              ["<c-l>"] = custom_pickers.actions.set_folders,
            },
          },
        },
      }

      opts.file_ignore_patterns = {
        "index.d.ts",
      }

      -- opts.extensions = {
      --   dash = {
      --     fileTypeKeywords = {
      --       NvimTree = false,
      --       TelescopePrompt = false,
      --       terminal = false,
      --       packer = false,
      --       -- a table of strings will search on multiple keywords
      --       typescript = { "typescript", "javascript", "css", "html" },
      --       typescriptreact = { "typescript", "javascript", "react", "css", "html" },
      --       javascriptreact = { "javascript", "react", "css", "html" },
      --     },
      --   },
      -- },

      tel.setup(opts)
      tel.load_extension("fzf")
    end,
  },

  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make",
  --     config = function()
  --       require("telescope").load_extension("fzf")
  --     end,
  --   },
  -- },

  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "princejoogie/dir-telescope.nvim",
  --     config = function()
  --       require("dir-telescope").setup({
  --         hidden = true,
  --         respect_gitignore = true,
  --       })
  --     end,
  --   },
  -- },
}
