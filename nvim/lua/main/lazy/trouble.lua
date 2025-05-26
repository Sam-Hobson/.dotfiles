return {
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
			vim.keymap.set("n", "<leader>cq", "<cmd>Trouble qflist toggle<cr>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>ce", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
			vim.keymap.set(
				"n",
				"<leader>cE",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				{ silent = true, noremap = true }
			)
			vim.keymap.set(
				"n",
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
				{ silent = true, noremap = true }
			)
			vim.keymap.set(
				"n",
				"gh",
				"<cmd>Trouble lsp toggle focus=true auto_refresh=false<cr>",
				{ silent = true, noremap = true }
			)
			vim.keymap.set(
				"n",
				"gH",
				"<cmd>Trouble lsp_references toggle focus=true auto_refresh=false<cr>",
				{ silent = true, noremap = true }
			)
			vim.keymap.set(
				"n",
				"gd",
				"<cmd>Trouble lsp_definitions toggle focus=true auto_refresh=false<cr>",
				{ silent = true, noremap = true }
			)
			vim.keymap.set(
				"n",
				"gI",
				"<cmd>Trouble lsp_implementations toggle focus=true auto_refresh=false<cr>",
				{ silent = true, noremap = true }
			)
		end,
	},
}
