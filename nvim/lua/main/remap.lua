vim.g.mapleader = " "

-- Generate a random hash at the cursor, this is useful for logging functions.
--
function RandomHash()
    local random_string = vim.fn.systemlist('openssl rand -hex 4')[1]
    vim.api.nvim_put({ random_string }, 'c', true, true)
end
vim.keymap.set("n", "<C-h>", "<cmd>lua RandomHash()<CR>")

-- Open the explorer
vim.keymap.set("n", "<leader><space>", vim.cmd.Oil)

-- Drag lines around
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- Cursor doesn't move for J
vim.keymap.set("n", "n", "nzzzv") -- Centre screen with n
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over stuff without overwriting paste register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Paste over stuff without overwriting paste register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)

-- Quickfix stuff
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", "<cmd>!chown $USER %<CR>", { silent = true })

vim.keymap.set("n", "<leader>qq", "<cmd>lua require('main.packer')<CR>");

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>");
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>");

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

