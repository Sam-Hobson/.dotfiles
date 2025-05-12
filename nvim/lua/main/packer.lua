return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	})

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use { "ellisonleao/gruvbox.nvim" }

	use("folke/trouble.nvim")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")
	use("nvim-treesitter/nvim-treesitter-context");

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		}
	}

	use("terrortylor/nvim-comment")
	use({ "kylechui/nvim-surround", tag = "*" })
	use("nvim-tree/nvim-web-devicons")

	use("nguyenvukhang/nvim-toggler")

	-- Markdown
	use("dhruvasagar/vim-table-mode")
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})
	use({
		"michaelb/sniprun",
		run = 'sh ./install.sh',
	})

	-- use("sam-hobson/extended_attributes.nvim")
end)
