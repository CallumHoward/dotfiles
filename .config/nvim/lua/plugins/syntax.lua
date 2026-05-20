--- Swap the treesitter node under cursor with its adjacent named sibling.
--- Walks up the tree to find a swappable node, then re-enters visual mode on it.
local function swap_with_sibling(direction)
  local node = vim.treesitter.get_node()
  if not node then return end

  -- Walk up to the nearest node that has a sibling in the target direction
  local sibling
  while node do
    sibling = direction == "next" and node:next_named_sibling() or node:prev_named_sibling()
    if sibling then break end
    node = node:parent()
  end
  if not node or not sibling then return end

  local buf = vim.api.nvim_get_current_buf()
  local nr, sr = { node:range() }, { sibling:range() }
  local nt = vim.split(vim.treesitter.get_node_text(node, buf), "\n", { plain = true })
  local st = vim.split(vim.treesitter.get_node_text(sibling, buf), "\n", { plain = true })

  -- Determine buffer order and replace later range first to preserve positions
  local a_r, b_r, a_t, b_t -- a=earlier, b=later
  if nr[1] < sr[1] or (nr[1] == sr[1] and nr[2] < sr[2]) then
    a_r, b_r, a_t, b_t = nr, sr, nt, st
  else
    a_r, b_r, a_t, b_t = sr, nr, st, nt
  end
  vim.api.nvim_buf_set_text(buf, b_r[1], b_r[2], b_r[3], b_r[4], a_t)
  vim.api.nvim_buf_set_text(buf, a_r[1], a_r[2], a_r[3], a_r[4], b_t)

  -- Compute where our node's text landed (0-indexed row/col)
  local new_start_row, new_start_col
  if direction == "next" then
    -- Our text moved to the later position; adjust for size change of earlier replacement
    if a_r[1] == b_r[1] and #a_t == 1 and #b_t == 1 then
      new_start_row, new_start_col = b_r[1], b_r[2] + (#b_t[1] - #a_t[1])
    else
      new_start_row, new_start_col = b_r[1] + (#b_t - #a_t), b_r[2]
    end
  else
    new_start_row, new_start_col = a_r[1], a_r[2]
  end

  local new_end_row = new_start_row + #nt - 1
  local new_end_col = #nt == 1 and (new_start_col + #nt[1]) or #nt[#nt]

  -- Set visual marks and reselect with gv
  vim.fn.setpos("'<", { 0, new_start_row + 1, new_start_col + 1, 0 })
  vim.fn.setpos("'>", { 0, new_end_row + 1, new_end_col, 0 })
  vim.api.nvim_feedkeys("gv", "nx", false)
end

return {
  { "mustache/vim-mustache-handlebars", ft = { "handlebars", "mustache" } },
  { "kchmck/vim-coffee-script", ft = { "coffee" } },
  { "rhysd/vim-syntax-codeowners", ft = "codeowners" },
  -- { "norcalli/nvim-terminal.lua", opts = true },
  {
    -- Remove ]c/[c treesitter class mappings — conflict with gitsigns hunk navigation
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = function(_, opts)
      opts.move.keys.goto_next_start["]c"] = nil
      opts.move.keys.goto_previous_start["[c"] = nil
      return opts
    end,
    keys = {
      { "<M-h>", function() swap_with_sibling("prev") end, mode = "x", desc = "Swap node with previous sibling" },
      { "<M-l>", function() swap_with_sibling("next") end, mode = "x", desc = "Swap node with next sibling" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "svelte",
        "css",
        "styled",
        "ssh_config",
        "tmux",
        "editorconfig",
      })
    end,
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
    keys = {
      { "zT", "<cmd>TailwindFoldToggle<cr>", desc = "Toggle class folding" },
    },
  },
  {
    "m00qek/baleia.nvim",
    cmd = { "BaleiaColorize" },
    config = function()
      local baleia
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        if not baleia then
          baleia = require("baleia").setup({})
        end
        baleia.once(vim.api.nvim_get_current_buf())
      end, {})
    end,
  },
}
