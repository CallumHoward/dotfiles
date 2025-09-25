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
      {
        "<leader>gM",
        function()
          Snacks.picker.files({
            ---@param opts snacks.picker.git.files.Config
            ---@type snacks.picker.finder
            finder = function(opts, ctx)
              local args = git_args(opts.args, "--no-pager", "diff", "master...HEAD", "--no-color", "--no-ext-diff", "--name-only")
              if not opts.cwd then
                local uv = vim.uv or vim.loop
                opts.cwd = Snacks.git.get_root() or uv.cwd() or "."
                ctx.picker:set_cwd(opts.cwd)
              end
              local cwd = svim.fs.normalize(opts.cwd) or nil
              return require("snacks.picker.source.proc").proc({
                opts,
                {
                  cmd = "git",
                  args = args,
                  ---@param item snacks.picker.finder.Item
                  transform = function(item)
                    item.cwd = cwd
                    item.file = item.text
                  end,
                  preview = function(item)
                    return {
                      text = item.file,
                      ft = "diff",
                      loc = false
                    }
                  end,
                },
              }, ctx)
            end,
          })
        end,
        desc = "Git Changed Files",
      },
      {
        "<leader>fG",
        function()
          Snacks.picker.git_diff({
            ---@param opts snacks.picker.git.Config
            ---@type snacks.picker.finder
            finder = function(opts, ctx)
              local args = git_args(opts.args, "--no-pager", "diff", "master...HEAD", "--no-color", "--no-ext-diff")
              local file, line ---@type string?, number?
              local header, hunk = {}, {} ---@type string[], string[]
              local header_len = 4
              local finder = require("snacks.picker.source.proc").proc({
                opts,
                { cmd = "git", args = args },
              }, ctx)
              return function(cb)
                local function add()
                  if file and line and #hunk > 0 then
                    local diff = table.concat(header, "\n") .. "\n" .. table.concat(hunk, "\n")
                    cb({
                      text = file .. ":" .. line,
                      diff = diff,
                      file = file,
                      pos = { line, 0 },
                      preview = { text = diff, ft = "diff", loc = false },
                    })
                  end
                  hunk = {}
                end
                finder(function(proc_item)
                  local text = proc_item.text
                  if text:find("diff", 1, true) == 1 then
                    add()
                    file = text:match("^diff .* a/(.*) b/.*$")
                    header = { text }
                    header_len = 4
                  elseif file and #header < header_len then
                    if text:find("^deleted file") then
                      header_len = 5
                    end
                    header[#header + 1] = text
                  elseif text:find("@", 1, true) == 1 then
                    add()
                    -- Hunk header
                    -- @example "@@ -157,20 +157,6 @@ some content"
                    line = tonumber(string.match(text, "@@ %-.*,.* %+(.*),.* @@"))
                    hunk = { text }
                  elseif #hunk > 0 then
                    hunk[#hunk + 1] = text
                  else
                    error("unexpected line: " .. text)
                  end
                end)
                add()
              end
            end,
          })
        end,
        desc = "Git Diff Master",
      },
    },
  },
}
