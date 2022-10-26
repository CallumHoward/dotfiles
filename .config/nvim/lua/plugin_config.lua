-- Testing
-- vim.cmd('let test#javascript#jest#options = "--color=always"')

-- -- Lsp Signature
-- require("lsp_signature").setup({
--   bind = true,
--   hint_enable = false,
--   handler_opts = {
--     border = "none",
--   },
--   padding = " ",
-- })

-- Import cost config
-- vim.api.nvim_exec(
--   [[
--     augroup ImportCostAutogroup
--       autocmd!
--       autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx silent ImportCost
--     augroup END
--   ]],
--   true
-- )

-- Package info config
-- local pi = require("package-info")
-- pi.setup({
--   colors = {
--     up_to_date = "#565f89", -- Text color for up to date package virtual text
--     outdated = "#e0af68", -- Text color for outdated package virtual text
--   },
-- })
-- vim.keymap.set("n", "<leader>ns", pi.show) -- Show package versions
-- vim.keymap.set("n", "<leader>nc", pi.hide) -- Hide package versions
-- vim.keymap.set("n", "<leader>nu", pi.update) -- Update package on line
-- vim.keymap.set("n", "<leader>nd", pi.delete) -- Delete package on line
-- vim.keymap.set("n", "<leader>ni", pi.install) -- Install a new package
-- vim.keymap.set("n", "<leader>nr", pi.reinstall) -- Reinstall dependencies
-- vim.keymap.set("n", "<leader>np", pi.changeversion) -- Install a different package version

-- Debug
-- require("dapui").setup()

-- -- Configure all installed debuggers
-- local dap_install = require("dap-install")

-- local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
-- for _, debugger in ipairs(dbg_list) do
--   dap_install.config(debugger)
-- end

-- require("flutter-tools").setup({
--   widget_guides = {
--     enabled = true,
--   },
--   outline = {
--     open_cmd = "30vnew",
--   },
-- })
