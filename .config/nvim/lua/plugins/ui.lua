return {
  {
    "snacks.nvim",
    init = function()
      local function set_hl()
        vim.api.nvim_set_hl(0, "NeovimMarkBlade", { fg = "#1682c8", default = true })
        vim.api.nvim_set_hl(0, "NeovimMarkRBlade", { fg = "#4b9641", default = true })
        vim.api.nvim_set_hl(0, "NeovimMarkCross", { fg = "#6ab946", default = true })
      end
      set_hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
    end,
    opts = {
      indent = { enabled = true, animate = { enabled = false } },
      scroll = {
        animate = {
          easing = "outQuad",
        },
      },
      dashboard = {
        preset = {
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          {
            align = "center",
            padding = 1,
            text = {
              { " " },
              { "◢███", hl = "NeovimMarkBlade" },
              { "█◣", hl = "NeovimMarkCross" },
              { "        " },
              { "███◣", hl = "NeovimMarkRBlade" },
              { "  \n" },
              { "◢████", hl = "NeovimMarkBlade" },
              { "██◣", hl = "NeovimMarkCross" },
              { "       " },
              { "████◣", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "█████", hl = "NeovimMarkBlade" },
              { "███◣", hl = "NeovimMarkCross" },
              { "      " },
              { "█████", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "█████", hl = "NeovimMarkBlade" },
              { "████◣", hl = "NeovimMarkCross" },
              { "     " },
              { "█████", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "█████", hl = "NeovimMarkBlade" },
              { "█████◣", hl = "NeovimMarkCross" },
              { "    " },
              { "█████", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "█████", hl = "NeovimMarkBlade" },
              { " " },
              { "◥████◣", hl = "NeovimMarkCross" },
              { "   " },
              { "█████", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "█████", hl = "NeovimMarkBlade" },
              { "  " },
              { "◥████◣", hl = "NeovimMarkCross" },
              { "  " },
              { "█████", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "█████", hl = "NeovimMarkBlade" },
              { "   " },
              { "◥████◣", hl = "NeovimMarkCross" },
              { " " },
              { "█████", hl = "NeovimMarkRBlade" },
              { " \n" },
              { "◥████", hl = "NeovimMarkBlade" },
              { "    " },
              { "◥████", hl = "NeovimMarkCross" },
              { "█████◤", hl = "NeovimMarkRBlade" },
              { " \n" },
              { " " },
              { "◥███", hl = "NeovimMarkBlade" },
              { "     " },
              { "◥███", hl = "NeovimMarkCross" },
              { "████◤", hl = "NeovimMarkRBlade" },
              { "  \n" },
              { "  " },
              { "◥██", hl = "NeovimMarkBlade" },
              { "      " },
              { "◥██", hl = "NeovimMarkCross" },
              { "███◤", hl = "NeovimMarkRBlade" },
              { "   " },
            },
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
  {
    -- Right click menu
    "nvzone/volt",
    lazy = true,
  },
  {
    "nvzone/menu",
    lazy = true,
    keys = {
      mode = { "n", "v" },
      "<RightMouse>",
    },
    config = function()
      vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
        require("menu.utils").delete_old_menus()

        vim.cmd.exec('"normal! \\<RightMouse>"')

        -- clicked buf
        local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

        require("menu").open(options, { mouse = true, border = true })
      end, {})
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bd", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other visible buffers" },
      { "<S-h>", false },
      { "<S-l>", false },
    },
  },
  {
    "kshenoy/vim-signature",
    event = "BufEnter",
  },
  -- preview colours
  {
    "RRethy/vim-hexokinase",
    build = { "make hexokinase" },
    ft = {
      "css",
      "html",
      "scss",
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "handlebars",
      "vim",
      "lua",
      "conf",
    },
  },
  -- icons
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      extension = {
        ["test.tsx"] = { glyph = "", hl = "MiniIconsOrange" },
        ["test.ts"] = { glyph = "󰛦", hl = "MiniIconsOrange" },
        ["spec.ts"] = { glyph = "󰯲", hl = "MiniIconsYellow" },
        ["stories.tsx"] = { glyph = "󰬚", hl = "MiniIconsRed" },
        ["story.tsx"] = { glyph = "󰬚", hl = "MiniIconsRed" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
        typescriptreact = { glyph = "", hl = "MiniIconsBlue" },
        typescript = { glyph = "󰛦", hl = "MiniIconsBlue" },
        yaml = { glyph = "", hl = "MiniIconsPurple" },
      },
    },
  },
}
