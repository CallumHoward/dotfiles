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
        "<leader>fG", -- "f" for files, "g" for git
        function()
          -- 1. Execute the git command to get a list of changed file names.
          --    vim.fn.systemlist() runs a shell command and returns its output as a Lua table (list).
          local git_files = vim.fn.systemlist("git diff master...HEAD --name-only")

          -- 2. Handle cases where the command fails or returns no files.
          --    vim.v.shell_error is non-zero if the last command failed.
          if vim.v.shell_error ~= 0 then
            vim.notify("Not a git repository or 'main' branch not found.", vim.log.levels.ERROR)
            -- As a fallback, try with 'master'
            git_files = vim.fn.systemlist("git diff master...HEAD --name-only")
            if vim.v.shell_error ~= 0 then
              vim.notify("Also failed to find 'master' branch.", vim.log.levels.ERROR)
              return
            end
          end

          if #git_files == 0 then
            vim.notify("No files changed since main/master.", vim.log.levels.INFO)
            return
          end

          -- 3. Open the Snacks picker with the list of files.
          --    We pass the `git_files` table to the `items` option.
          require("snacks").picker({
            items = git_files,
            title = "Changed Files (since main/master)",
          })
        end,
        desc = "Git Changed Files",
      },
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
