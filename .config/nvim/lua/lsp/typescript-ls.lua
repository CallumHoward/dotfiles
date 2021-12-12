-- make sure to only run this once!
local opts = {
  on_attach = function(client)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    vim.api.nvim_exec(
      [[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]],
      true
    )

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,

      -- import all
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        buffers = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files = 2, -- git files or files with relative path markers
        same_file = 1, -- add to existing import statement
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_opts = {},

      -- formatting
      enable_formatting = true,
      formatter = "prettierd",
      formatter_opts = {},

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
  end,
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
local server_available, requested_server = lsp_installer_servers.get_server("tsserver")

if server_available then
  requested_server:on_ready(function()
    requested_server:setup(opts)
  end)
end
