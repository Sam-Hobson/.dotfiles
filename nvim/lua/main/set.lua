vim.opt.number = true
vim.opt.relativenumber = true

-- By default this is handled by guess-indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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

function SearchCount()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local result = vim.fn.searchcount({ maxcount = 9999 })
  if result.total == 0 then
    return ""
  end
  return string.format("[%d/%d]", result.current, result.total)
end
vim.opt.statusline = "%<%f %h%m%r%=%{v:lua.SearchCount()}  %{get(b:,'gitsigns_status','')}  %(%l,%c%V%)  %P  %{&fileformat}"
vim.opt.cmdheight = 0

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- Set the background to be transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })

vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.mousescroll = "ver:1,hor:0"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[ set nofoldenable ]])

-- Spelling
vim.opt.spelllang = "en_au"
vim.opt.spell = true
vim.opt.spelloptions = "camel"

-- List chars (show tabs + spaces)
vim.opt.list = true
vim.opt.listchars = {
  tab = '  ',
  leadmultispace = '·   ',
}
