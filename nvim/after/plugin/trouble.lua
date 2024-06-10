require("trouble").setup {}

vim.keymap.set("n", "<leader>cq", "<cmd>Trouble qflist toggle<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>ce", "<cmd>Trouble diagnostics toggle<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>cE", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=true<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "gh", "<cmd>Trouble lsp toggle focus=true<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions toggle focus=true<cr>",
    { silent = true, noremap = true }
)

-- vim.keymap.set("n", "gi", "<cmd>TroubleToggle lsp_implementations<cr>",
--     { silent = true, noremap = true }
-- )
