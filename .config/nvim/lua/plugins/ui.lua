return {
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = true, animate = { enabled = false } },
      scroll = {
        animate = {
          easing = "outQuad",
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
    "echasnovski/mini.icons",
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
