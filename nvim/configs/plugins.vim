call plug#begin('/home/sam/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip', { 'do': 'make install_jsregexp' } " Snippets plugin
Plug 'mfussenegger/nvim-lint'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'ray-x/lsp_signature.nvim'
Plug 'j-hui/fidget.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'p00f/nvim-ts-rainbow'
" Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/nvim-treesitter-context'

" Haskell
" Plug 'monkoose/fzf-hoogle.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}

" Colour
" Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Git
Plug 'lewis6991/gitsigns.nvim'

" Spelling
Plug 'kamykn/spelunker.vim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'stevearc/dressing.nvim'

" Panels
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mbbill/undotree'
" Plug 'liuchengxu/vista.vim'

" Statusline
Plug 'NTBBloodbath/galaxyline.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Formatting
Plug 'mhartington/formatter.nvim'

" Runner
Plug 'CRAG666/code_runner.nvim'
Plug 'CRAG666/betterTerm.nvim'

" Comfort
Plug 'famiu/bufdelete.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Folds
" Plug 'anuvyklack/pretty-fold.nvim'

" Other
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'folke/which-key.nvim'
Plug 'samirettali/shebang.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'windwp/nvim-autopairs'
Plug 'rmagatti/auto-session'
Plug 'tpope/vim-surround'
" Plug 'chentoast/marks.nvim'

call plug#end()
