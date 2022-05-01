--- Bootstrap packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end
--- End bootstrap

-- Auto compile when there are changes in plugins.lua
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

require("packer").init({
  max_jobs = 8,
})

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager

  -- Colorscheme
  use("folke/tokyonight.nvim")
  use("cocopon/iceberg.vim")
  use("mhartington/oceanic-next")
  use("w0ng/vim-hybrid")

  -- Cosmetic features
  use("kyazdani42/nvim-web-devicons")
  use("joeytwiddle/sexy_scroller.vim")
  use("dstein64/nvim-scrollview")
  use("lukas-reineke/indent-blankline.nvim")
  use({ "romgrk/barbar.nvim", requires = { "~/git/nvim-web-devicons" } })
  use("kshenoy/vim-signature")
  -- use 'folke/which-key.nvim'
  use({ "~/git/vim-hexokinase", run = { "make hexokinase" } }) -- preview colours
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
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("vim-scripts/SyntaxAttr.vim")
  use("powerman/vim-plugin-AnsiEsc")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use({ "~/git/vim-import-cost", run = "npm install" })
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
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/vim-vsnip")
  use("dmitmel/cmp-cmdline-history")
  use("ray-x/cmp-treesitter")
  use("andersevenrud/cmp-tmux")
  use("onsails/lspkind-nvim")
  use("rafamadriz/friendly-snippets")
  use({ "tzachar/cmp-tabnine", run = "./install.sh" })

  -- Debug
  -- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  -- use("Pocco81/DAPInstall.nvim")
  -- use("nvim-telescope/telescope-dap.nvim")

  -- Wrap external tools
  use({ "francoiscabrol/ranger.vim", requires = { "rbgrouleff/bclose.vim" } })
  -- use 'kevinhwang91/rnvimr'
  use("mhartington/formatter.nvim")
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
  use("CallumHoward/vim-lcov")

  -- Source control features
  use({
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("plugins.gitsigns_config") end,
  })
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use("sindrets/diffview.nvim")
  use("ygm2/rooter.nvim")

  -- Other features
  use("kyazdani42/nvim-tree.lua")
  use("dstein64/vim-startuptime")

  -- Mapping plugins
  use("kwkarlwang/bufjump.nvim")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-rsi")
  use("tpope/vim-commentary")
  use("tpope/vim-sleuth")
  use("tpope/vim-abolish")
end)
