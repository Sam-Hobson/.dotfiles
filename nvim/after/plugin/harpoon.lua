
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>ba", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>bs", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>bd", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>bf", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>bz", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>bx", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>bc", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>bv", function() ui.nav_file(8) end)

