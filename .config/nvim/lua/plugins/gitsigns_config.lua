local space = "    "

require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  preview_config = { border = "none" },
  current_line_blame = true,
  current_line_blame_opts = { virt_text_priority = 1 },
  current_line_blame_formatter_opts = { relative_time = true },
  -- current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",
  current_line_blame_formatter_nc = space .. "You, a while ago • Uncommitted changes",
  current_line_blame_formatter = function(name, blame_info, opts)
    if blame_info.author:gsub("%s+", "") == name then
      blame_info.author = "You"
    end

    local text
    local date_time

    if opts.relative_time then
      date_time = require("gitsigns.util").get_relative_time(tonumber(blame_info["author_time"]))
    else
      date_time = os.date("%Y-%m-%d", tonumber(blame_info["author_time"]))
    end

    text = string.format(space .. "%s, %s • %s", blame_info.author, date_time, blame_info.summary)

    return { { text, "GitSignsCurrentLineBlame" } }
  end,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end)
    map("n", "<leader>b", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end)
    map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})
local g = require("gitsigns")
vim.keymap.set("n", "<leader>ggm", function()
  g.change_base("master", true)
end)
vim.keymap.set("n", "<leader>ggh", function()
  g.change_base("HEAD", true)
end)
vim.keymap.set(
  "n",
  "<leader>gg",
  ":lua require('gitsigns').change_base('HEAD~', true)<Left><Left><Left><Left><Left><Left><Left><Left>"
)
vim.keymap.set("n", "<leader>hl", "<cmd>Gitsigns setqflist<CR>")
