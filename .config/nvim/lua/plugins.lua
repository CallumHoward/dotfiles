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

-- Limit parallel jobs to prevent failures
require("packer").init({
  max_jobs = 8,
})

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  use({
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
      -- require("impatient").enable_profile() -- uncommend and use :LuaCacheProfile
    end,
  }) -- Startup cache

  -- Colorscheme
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("plugins.tokyonight_config")
    end,
  })
  -- use("cocopon/iceberg.vim")
  -- use("mhartington/oceanic-next")
  -- use("w0ng/vim-hybrid")

  -- Cosmetic features
  use("kyazdani42/nvim-web-devicons")
  use("joeytwiddle/sexy_scroller.vim")
  use("dstein64/nvim-scrollview")
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent_blankline_config")
    end,
  })
  use({ "romgrk/barbar.nvim", tag = "release/1.0.0", requires = { "kyazdani42/nvim-web-devicons" } })
  use("kshenoy/vim-signature")
  -- use 'folke/which-key.nvim'
  use({ "RRethy/vim-hexokinase", run = { "make hexokinase" } }) -- preview colours
  use("KabbAmine/vCoolor.vim") -- show OS colour picker
  use("rcarriga/nvim-notify")

  -- Selector
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require("plugins.telescope_config")
    end,
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("kevinhwang91/nvim-bqf")

  -- Language features
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter_config")
    end,
  })
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("vim-scripts/SyntaxAttr.vim")
  use("powerman/vim-plugin-AnsiEsc")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use({ "yardnsm/vim-import-cost", run = "npm install" })
  use({'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'})
  use({
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
  })

  -- LSP features
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "jose-elias-alvarez/null-ls.nvim" } })
  use("simrat39/symbols-outline.nvim")
  use("kosayoda/nvim-lightbulb")
  use("ray-x/lsp_signature.nvim")
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("plugins.nvim_navic_config")
    end,
  })
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  })

  -- Filetype support
  use("mustache/vim-mustache-handlebars")
  use("jxnblk/vim-mdx-js")
  use("rhysd/vim-syntax-codeowners")

  -- Completion
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-calc")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-emoji")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lsp-document-symbol")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("dmitmel/cmp-cmdline-history")
  use("ray-x/cmp-treesitter")
  use("andersevenrud/cmp-tmux")
  use("onsails/lspkind-nvim")
  use("rafamadriz/friendly-snippets")
  use({ "tzachar/cmp-tabnine", run = "./install.sh" })
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp_config")
    end,
  })

  -- Debug
  -- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  -- use("Pocco81/DAPInstall.nvim")
  -- use("nvim-telescope/telescope-dap.nvim")

  -- Wrap external tools
  use({ "francoiscabrol/ranger.vim", requires = { "rbgrouleff/bclose.vim" } })
  -- use 'kevinhwang91/rnvimr'
  use({
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter_config")
    end,
  })
  use({
    "iamcco/markdown-preview.nvim",
    run = [[sh -c 'cd app && yarn install']],
    -- cmd = "MarkdownPreview",
  })
  use({
    "rcarriga/vim-ultest",
    requires = { "janko/vim-test" },
    run = ":UpdateRemotePlugins",
  })
  use("hauleth/asyncdo.vim")
  -- use({ "mrjones2014/dash.nvim", requires = { "nvim-telescope/telescope.nvim" }, run = "make install" })
  use({ "CallumHoward/vim-lcov", cmd = "LcovVisible" })

  -- Source control features
  use({
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.gitsigns_config")
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use("sindrets/diffview.nvim")
  use("ygm2/rooter.nvim")

  -- Other features
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim_tree_config")
    end,
  })
  use("dstein64/vim-startuptime")

  -- Mapping plugins
  use("kwkarlwang/bufjump.nvim")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-rsi")
  use("tpope/vim-commentary")
  use("tpope/vim-sleuth")
  use("tpope/vim-abolish")

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
