---@param ... (string|string[]|nil)
local function git_args(...)
  local ret = { "-c", "core.quotepath=false" } ---@type string[]
  for i = 1, select("#", ...) do
    local arg = select(i, ...)
    vim.list_extend(ret, type(arg) == "table" and arg or { arg })
  end
  return ret
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            -- stylua: ignore
            keys = {
              ["<c-a>"] = { "select_all", mode = "n" },
              ["<c-b>"] = { "preview_scroll_up", mode = "n" },
              ["<c-f>"] = { "preview_scroll_down", mode = "n" },
              ["<a-f>"] = { "toggle_follow", mode = "n" },
              ["<a-d>"] = { "inspect", mode = "n" },
              -- ["<c-d>"] = { "list_scroll_down", mode = "n" },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>fP", function() Snacks.picker() end, desc = "Pickers" },
      { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = vim.fn.getcwd() }}) end, desc = "Recent (Root Dir)" },
      { "<leader>gM", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = "Git Diff (origin)" },
    },
  },
}
