vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true

vim.opt.cursorline = true

vim.opt.guicursor = ""

vim.opt.cmdheight = 1

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.fileformats = { "unix", "dos" }

vim.opt.statusline = "%<%f %h%m%r%=[ %{v:lua.custom_treesitter_statusline()} ] [ %(%l,%c%V%) ] [ %P ] [ %{&fileformat} ]"

function custom_treesitter_statusline()
  local filepath = vim.fn.expand('%:p')
  local max_length = 150
  local available_space = vim.fn.winwidth(0) - #filepath - 15

  local treesitter_status = vim.fn['nvim_treesitter#statusline'](available_space)
  return treesitter_status
end

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.mousescroll="ver:1,hor:0"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[ set nofoldenable ]])

-- Spelling
vim.opt.spelllang = 'en_au'
vim.opt.spell = true
vim.opt.spelloptions = "camel"
