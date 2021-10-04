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

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager

  -- Colorscheme
  use("~/neodark")
  use("romgrk/doom-one.vim")
  use("folke/tokyonight.nvim")
  use("cocopon/iceberg.vim")
  use("mhartington/oceanic-next")
  use("w0ng/vim-hybrid")
  use({ "maaslalani/nordbuddy", "tjdevries/colorbuddy.nvim" })

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

  -- Selector
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("kevinhwang91/nvim-bqf")

  -- Language features
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", branch = "0.5-compat" })
  use("nvim-treesitter/playground")
  use("vim-scripts/SyntaxAttr.vim")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use({ "~/git/vim-import-cost", run = "npm install" })

  -- LSP features
  use("neovim/nvim-lspconfig")
  use("kabouzeid/nvim-lspinstall")
  use("liuchengxu/vista.vim")
  use("kosayoda/nvim-lightbulb")
  use("ray-x/lsp_signature.nvim")
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  })

  -- Filetype support
  use("mustache/vim-mustache-handlebars")

  -- Completion
  use("hrsh7th/nvim-compe")
  use("andersevenrud/compe-tmux")
  -- If packer fails for tabnine, do
  -- `cd ~/.local/share/nvim/site/pack/packer/start/compe-tabnine && ./install.sh`
  -- use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'}
  use("tamago324/compe-zsh")
  use("hrsh7th/vim-vsnip")
  use("rafamadriz/friendly-snippets")
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "jose-elias-alvarez/null-ls.nvim" } })
  use("gelguy/wilder.nvim")

  -- Wrap external tools
  use({ "francoiscabrol/ranger.vim", requires = { "rbgrouleff/bclose.vim" } })
  -- use 'kevinhwang91/rnvimr'
  use("mhartington/formatter.nvim")
  use({
    "iamcco/markdown-preview.nvim",
    run = [[sh -c 'cd app && yarn install']],
    -- cmd = 'MarkdownPreview'
  })
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "rcarriga/vim-ultest",
    requires = { "janko/vim-test" },
    run = ":UpdateRemotePlugins",
  })

  -- Source control features
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use("sindrets/diffview.nvim")
  use("ygm2/rooter.nvim")

  -- Other features
  -- use {"kyazdani42/nvim-tree.lua", opt = true, cmd = { 'NvimTreeToggle' }}
  use("kyazdani42/nvim-tree.lua")
  use("dstein64/vim-startuptime")

  -- Mapping plugins
  use("kwkarlwang/bufjump.nvim")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-rsi")
  use("tpope/vim-commentary")
  use("tpope/vim-sleuth")
end)
