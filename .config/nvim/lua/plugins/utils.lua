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
          Snacks.picker.git_diff({
            finder = function(opts, ctx)
              local file, line
              local header, hunk = {}, {}
              local header_len = 4
              local finder = require("snacks.picker.source.proc").proc({
                opts,
                {
                  cmd = "git",
                  -- stylua: ignore
                  args = { "-c", "core.quotepath=false", "--no-pager", "diff", "origin/master...HEAD", "--no-color", "--no-ext-diff" },
                },
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
