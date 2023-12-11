require("main.set")
require("main.remap")


local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local whitespace = augroup('MyGroup', {})
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end


autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150,
        })
    end,
})


-- Delete trailing whitespace
autocmd({"BufWritePre"}, {
    group = whitespace,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings="noma nomod nu nobl nowrap ro"

