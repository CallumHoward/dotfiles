return {
  "kevinhwang91/rnvimr",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    vim.api.nvim_create_user_command("Ranger", "RnvimrToggle", {
      desc = "Toggle Ranger",
    })
    vim.g.rnvimr_enable_picker = 1
    vim.keymap.set("n", "<leader>r", "<Cmd>Ranger<CR><C-l>", { desc = "Ranger" })
    local expr = " <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? "
    vim.cmd("cabbrev ra" .. expr .. "'Ranger' : 'ra')<CR>")
    vim.cmd("cabbrev va" .. expr .. "'vs \\| Ranger' : 'ra')<CR>")
    vim.cmd("cabbrev spa" .. expr .. "'sp \\| Ranger' : 'ra')<CR>")
    vim.cmd("cabbrev tra" .. expr .. "'tabe \\| Ranger' : 'ra')<CR>")

    -- Causes visual glitch
    vim.cmd([[ RnvimrStartBackground ]])
  end,
}
