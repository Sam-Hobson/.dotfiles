" set nocompatible

" Settings
set clipboard+=unnamedplus
set incsearch
set ignorecase
set mouse=a
set hidden
set number
set relativenumber
set wildmenu
" set noequalalways

set autoindent
filetype plugin indent on
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

" Folding
" set foldenable
" set foldlevelstart=10
" set foldnestmax=1
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" set sidescroll=1
set scrolloff=4

set cursorline

" set nowrap
set linebreak

set numberwidth=1

set undofile
set undodir=/home/sam/.config/nvim/undodir-nightly//

set shell=/usr/bin/zsh

set termguicolors

" Automatically reload the buffer on save.
set autoread

set cmdheight=0
set scrollback=100000

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Highlight yanked area.
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})
augroup END

" Show trailing whitespace:
hi EoLSpace ctermbg=238 guibg=#db4b4b
match EoLSpace /\s\+$/

" Css
autocmd FileType css setl iskeyword+=-

" Spelunker (spelling)
set nospell
let g:spelunker_check_type = 1
highlight SpelunkerSpellBad cterm=undercurl ctermfg=247 gui=undercurl
highlight SpelunkerComplexOrCompoundWord cterm=undercurl ctermfg=NONE gui=undercurl guifg=NONE

lua <<EOF
  require('kommentary.config').configure_language("default", {
      prefer_single_line_comments = true,
  })
  -- require'bufferline'.setup{}
  -- dofile "/home/sam/.config/nvim/lua/tabbar.lua"
  require'colorizer'.setup()
  require("which-key").setup()
  require("auto-session").setup()
  require("spider").setup({skipInsignificantPunctuation = true})
  dofile "/home/sam/.config/nvim/lua/bufSwitch.lua"
  dofile "/home/sam/.config/nvim/lua/fidgetConf.lua"
  dofile "/home/sam/.config/nvim/lua/betterTerminal.lua"
  --dofile "/home/sam/.config/nvim/lua/marksConf.lua"
  dofile "/home/sam/.config/nvim/lua/dressingConf.lua"
  dofile "/home/sam/.config/nvim/lua/lspConf.lua"
  dofile "/home/sam/.config/nvim/lua/cmpConf.lua"
  dofile "/home/sam/.config/nvim/lua/telescopeConf.lua"
  dofile "/home/sam/.config/nvim/lua/codeRunnerConf.lua"
  dofile "/home/sam/.config/nvim/lua/lspUtilsConf.lua"
  --dofile "/home/sam/.config/nvim/lua/pretty-folder.lua"
  dofile "/home/sam/.config/nvim/lua/gitSignsConf.lua"
  dofile "/home/sam/.config/nvim/lua/tree.lua"
  dofile "/home/sam/.config/nvim/lua/galaxyLineConf.lua"
  dofile "/home/sam/.config/nvim/lua/autopairs.lua"
  dofile "/home/sam/.config/nvim/lua/ts.lua"
  dofile "/home/sam/.config/nvim/lua/formattingConf.lua"
  dofile "/home/sam/.config/nvim/lua/linterConf.lua"
  dofile "/home/sam/.config/nvim/lua/lspSigConf.lua"
  dofile "/home/sam/.config/nvim/lua/theme.lua"
  dofile "/home/sam/.config/nvim/lua/indent.lua"
  require("luasnip.loaders.from_snipmate").lazy_load()
EOF

" Colour scheme
colorscheme tokyonight-night
