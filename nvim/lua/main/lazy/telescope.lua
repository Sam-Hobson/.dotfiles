return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.6",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})

		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>fW", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>fg", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
