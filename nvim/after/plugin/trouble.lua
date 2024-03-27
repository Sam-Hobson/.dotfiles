vim.keymap.set("n", "<leader>cq", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>ce", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>cE", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "gh", "<cmd>TroubleToggle lsp_references<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set("n", "gi", "<cmd>TroubleToggle lsp_implementations<cr>",
    { silent = true, noremap = true }
)

