-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local repo_path = "https://github.com/wbthomason/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", repo_path, install_path })
end
-- End bootstrap

-- Auto compile when there are changes in plugins.lua
local packer_user_config = vim.api.nvim_create_augroup("PackerUserConfig", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = packer_user_config,
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

-- Load vim pack plugins
vim.cmd("packadd! cfilter")
-- vim.cmd("packadd! termdebug")

-- Disable built-in vim plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  -- "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Limit parallel jobs to prevent failures
require("packer").init({
  max_jobs = 32,
})

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  use("lewis6991/impatient.nvim") -- Startup cache
  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  -- Colorscheme
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("plugins.tokyonight_config")
      vim.cmd("colorscheme tokyonight")
    end,
  })
  -- use("cocopon/iceberg.vim")
  -- use("mhartington/oceanic-next")
  -- use("w0ng/vim-hybrid")

  -- Cosmetic features
  use("kyazdani42/nvim-web-devicons")
  use({ "joeytwiddle/sexy_scroller.vim", event = "BufEnter" })
  -- use({
  --   "dstein64/nvim-scrollview",
  --   config = function()
  --     vim.cmd("let g:scrollview_column = 1")
  --   end,
  -- })
  use({
    "CallumHoward/nvim-scrollbar",
    event = "BufReadPost",
    requires = { "kevinhwang91/nvim-hlslens", event = "BufRead" },
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("scrollbar").setup({
        handle = {
          color = "#2C3955",
        },
        marks = {
          Search = { color = colors.yellow },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
      require("hlslens").setup({
        auto_enable = false,
        nearest_float_when = "never",
      })
      require("scrollbar.handlers.search").setup()
    end,
  })
  use({
    "anuvyklack/windows.nvim",
    requires = {
      { "anuvyklack/middleclass", event = "BufWinEnter" },
      { "anuvyklack/animation.nvim", event = "BufWinEnter" },
    },
    keys = { "<C-w><Space>", "<C-w>_", "<C-w><Bar>", "<C-w>=" },
    config = function()
      vim.keymap.set("n", "<C-w><Space>", "<Cmd>WindowsMaximize<CR>")
      vim.keymap.set("n", "<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>")
      vim.keymap.set("n", "<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>")
      vim.keymap.set("n", "<C-w>=", "<Cmd>WindowsEqualize<CR>")

      require("windows").setup({
        autowidth = {
          enable = false,
        },
      })
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("plugins.indent_blankline_config")
    end,
  })
  -- use({ "romgrk/barbar.nvim", tag = "release/1.0.0", requires = { "kyazdani42/nvim-web-devicons" } })
  use({
    "romgrk/barbar.nvim",
    -- branch = "feat/hide-buffers",
    -- event = "BufReadPost",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      -- Nvim Tree integration
      local nvim_tree_events = require("nvim-tree.events")
      local bufferline_api = require("bufferline.api")

      local function get_tree_size()
        return require("nvim-tree.view").View.width + 1
      end

      nvim_tree_events.subscribe("TreeOpen", function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe("Resize", function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe("TreeClose", function()
        bufferline_api.set_offset(0)
      end)

      vim.keymap.set("n", "g>", "<Cmd>BufferMoveNext<CR>")
      vim.keymap.set("n", "g<", "<Cmd>BufferMovePrevious<CR>")

      require("bufferline").setup({
        hide = { inactive = true },
        auto_hide = true,
      })
    end,
  })
  use({ "kshenoy/vim-signature", event = "BufEnter" })
  use({
    "RRethy/vim-hexokinase",
    run = { "make hexokinase" },
    ft = require("plugins.hexokinase_config").ft,
  }) -- preview colours
  use({
    "KabbAmine/vCoolor.vim",
    keys = { "<leader>jc" },
    config = function()
      vim.cmd("let g:vcoolor_disable_mappings = 1")
      vim.cmd('let g:vcoolor_map = "<leader>jc"')
    end,
  }) -- show OS colour picker
  use({
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require("notify")
    end,
  })
  use({
    "luukvbaal/stabilize.nvim",
    event = "BufWinEnter",
    config = function()
      require("stabilize").setup()
    end,
  })

  -- Selector
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    event = "BufWinEnter",
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", event = "BufWinEnter" },
    },
    config = function()
      require("plugins.telescope_config")
    end,
  })
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("plugins.nvim_bqf_config")
    end,
  })

  -- Language features
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter_config")
    end,
  })
  use({ "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" } })
  use({ "nvim-treesitter/nvim-treesitter-textobjects", event = "BufWinEnter" })
  use({ "vim-scripts/SyntaxAttr.vim", cmd = "SynAttr" })
  -- use("powerman/vim-plugin-AnsiEsc")
  use({
    "Kasama/nvim-custom-diagnostic-highlight",
    event = "BufReadPost",
    config = function()
      require("nvim-custom-diagnostic-highlight").setup({})
    end,
  })
  use({
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("hlargs").setup({
        color = colors.yellow,
        hl_priority = 149,
      })
    end,
  })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufWinEnter" })
  use({
    "windwp/nvim-autopairs",
    event = "BufWinEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  })
  use({
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "xml",
      "markdown",
      "handlebars",
      "hbs",
    },
  })
  use({
    "axelvc/template-string.nvim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx" },
    config = function()
      require("template-string").setup({
        remove_template_string = true,
        restore_quotes = {
          normal = [["]],
          jsx = [["]],
        },
      })
    end,
  })
  use({
    "ThePrimeagen/refactoring.nvim",
    keys = { "<leader>cR" },
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("refactoring").setup()
      vim.keymap.set({ "n", "x" }, "<leader>cR", function()
        require("refactoring").select_refactor()
      end)
    end,
  })
  -- use({ "yardnsm/vim-import-cost", run = "npm install" })
  -- use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
  -- use({
  --   "vuki656/package-info.nvim",
  --   requires = "MunifTanjim/nui.nvim",
  -- })

  -- -- LSP features
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    config = function()
      require("lsp")
      require("lsp.emmet-ls")
      require("lsp.lua-ls")
      -- require("lsp.null-ls")
      require("lsp.typescript-ls")
      require("lsp.json-ls")
      require("lsp.stylelint-ls")
    end,
  })
  use("williamboman/nvim-lsp-installer")
  -- use({ "jose-elias-alvarez/nvim-lsp-ts-utils", after = "nvim-lspconfig", requires = { "jose-elias-alvarez/null-ls.nvim" } })
  use({
    "mxsdev/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    branch = "merge-jsx-tree",
    config = function()
      require("plugins.symbols_outline_config")
    end,
  })
  use({
    "kosayoda/nvim-lightbulb",
    after = "nvim-lspconfig",
    requires = "antoinemadec/FixCursorHold.nvim",
    config = function()
      vim.fn.sign_define("LightBulbSign", {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "",
        numhl = "DiagnosticSignWarn",
        priorioty = 12,
      })
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
  })
  -- use("ray-x/lsp_signature.nvim")
  use({
    "SmiteshP/nvim-navic",
    after = "nvim-lspconfig",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("plugins.nvim_navic_config")
    end,
  })
  -- use("nvim-lua/lsp-status.nvim")
  use({
    "smjonas/inc-rename.nvim",
    event = "BufReadPost",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<leader>cr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  })
  use({
    "folke/trouble.nvim",
    event = { "BufReadPost", "CmdlineEnter" },
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        use_diagnostic_signs = true,
      })
    end,
  })

  -- -- Filetype support
  use({ "mustache/vim-mustache-handlebars", ft = { "handlebars", "mustache" } })
  use({ "jxnblk/vim-mdx-js", ft = "markdown.mdx" })
  use({ "rhysd/vim-syntax-codeowners", ft = "codeowners" })

  -- -- Completion
  use({
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("plugins.cmp_config")
    end,
    requires = {
      { "onsails/lspkind-nvim" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
      { "dmitmel/cmp-cmdline-history", after = "nvim-cmp" },
      { "andersevenrud/cmp-tmux", after = "nvim-cmp" },
      -- { "ray-x/cmp-treesitter", after = "nvim-cmp" },
      -- { "tzachar/cmp-tabnine", after = "nvim-cmp", run = "./install.sh" },
      { "windwp/nvim-autopairs", after = "nvim-cmp" },
      {
        "hrsh7th/cmp-vsnip",
        requires = {
          { "hrsh7th/vim-vsnip", after = "nvim-cmp" },
          { "rafamadriz/friendly-snippets", after = "nvim-cmp" },
        },
        after = "nvim-cmp",
      },
    },
  })

  -- -- Debug
  -- -- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  -- -- use("Pocco81/DAPInstall.nvim")
  -- -- use("nvim-telescope/telescope-dap.nvim")

  -- Wrap external tools
  use({
    "francoiscabrol/ranger.vim",
    requires = { "rbgrouleff/bclose.vim", after = "ranger.vim" },
    event = "CmdlineEnter",
    keys = { "<leader>r" },
    config = function()
      vim.keymap.set("n", "<leader>r", "<Cmd>Ranger<CR>")
      vim.cmd("cabbrev ra <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ranger' : 'ra')<CR>")
      vim.cmd("cabbrev va <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vs \\| Ranger' : 'ra')<CR>")
      vim.cmd("cabbrev spa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'sp \\| Ranger' : 'ra')<CR>")
      vim.cmd("cabbrev tra <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabe \\| Ranger' : 'ra')<CR>")
    end,
  })
  -- use 'kevinhwang91/rnvimr'
  use({
    "mhartington/formatter.nvim",
    event = "BufWritePost",
    cmd = { "P", "Format", "FormatWrite" },
    config = function()
      require("plugins.formatter_config")
    end,
  })
  use({
    "iamcco/markdown-preview.nvim",
    run = [[sh -c 'cd app && yarn install']],
    setup = function()
      vim.g.mkdp_filetypes = { "markdown", "markdown.mdx" }
    end,
    ft = { "markdown", "markdown.mdx" },
  })
  use({
    "nvim-neotest/neotest",
    keys = { "<leader>jn", "<leader>jf", "<leader>ju" },
    requires = {
      "antoinemadec/FixCursorHold.nvim",
      { "haydenmeade/neotest-jest", event = "BufReadPost" },
      { "nvim-neotest/neotest-go", event = "BufReadPost" },
    },
    config = function()
      require("plugins.neotest_config")
    end,
  })
  use({
    "hauleth/asyncdo.vim",
    cmd = "Make",
    config = function()
      vim.cmd([[command! -bang -nargs=* -complete=file Make call asyncdo#run(<bang>0, &makeprg, <f-args>)]])
    end,
  })
  -- use({ "mrjones2014/dash.nvim", requires = { "nvim-telescope/telescope.nvim" }, run = "make install" })
  -- use({ "CallumHoward/vim-lcov", cmd = "LcovVisible" })
  use({ "Dkendal/nvim-coverage", cmd = "CoverageToggle" })

  -- -- Source control features
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufWinEnter",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.gitsigns_config")
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    keys = { "<leader>gb", "<leader>gy" },
    requires = "nvim-lua/plenary.nvim",
    config = function()
      local gl = require("gitlinker")
      local gla = require("gitlinker.actions")
      local function open_blame()
        gl.get_buf_range_url("n", { action_callback = gla.open_in_browser })
      end
      gl.setup()
      vim.keymap.set("n", "<leader>gb", open_blame)
      vim.keymap.set("v", "<leader>gb", open_blame)
    end,
  })
  use({
    "sindrets/diffview.nvim",
    event = "CmdlineEnter",
    config = function()
      require("plugins.diffview_config")
    end,
  })
  use({
    "akinsho/git-conflict.nvim",
    event = "BufReadPost",
    tag = "v1.0.0",
    config = function()
      require("git-conflict").setup()
    end,
  })
  use({ "ygm2/rooter.nvim", event = "BufWinEnter" })

  -- Other features
  use({
    "kyazdani42/nvim-tree.lua",
    event = "BufReadPost",
    config = function()
      require("plugins.nvim_tree_config")
    end,
  })
  -- use("vim-scripts/restore_view.vim") -- Save folds, cursor position etc.

  -- Mapping plugins
  use({
    "kwkarlwang/bufjump.nvim",
    keys = { "<M-o>", "<M-i>" },
    config = function()
      local bj = require("bufjump")
      vim.keymap.set("n", "<M-o>", bj.backward)
      vim.keymap.set("n", "<M-i>", bj.forward)
    end,
  })
  use({
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  })
  use({ "tpope/vim-surround", event = "BufWinEnter" })
  use({ "tpope/vim-repeat", keys = { "." } })
  use({ "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } })
  use({ "tpope/vim-sleuth", event = "BufWinEnter" })
  use({ "tpope/vim-abolish", event = "BufWinEnter" })
  use({ "fuadsaud/vim-textobj-variable-segment", requires = "kana/vim-textobj-user", event = "BufWinEnter" })
  -- use("mvolkmann/vim-js-arrow-function") -- TODO test this

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
