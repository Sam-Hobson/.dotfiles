-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { "ellisonleao/gruvbox.nvim" }

  use("folke/trouble.nvim")


  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use("nvim-treesitter/playground")
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("sindrets/diffview.nvim")
  use("nvim-treesitter/nvim-treesitter-context");

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use("terrortylor/nvim-comment")
  use({ "kylechui/nvim-surround", tag = "*" })
  use("nvim-tree/nvim-web-devicons")

  use("echasnovski/mini.pairs")
  -- use {
  --     "windwp/nvim-autopairs",
  --     event = "InsertEnter",
  --     config = function() require("nvim-autopairs").setup {} end
  -- }

  use("windwp/nvim-ts-autotag")
  use("nguyenvukhang/nvim-toggler")

end)

