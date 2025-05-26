return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local treesj = require("treesj")
		treesj.setup({
			use_default_keymaps = false,
			max_join_length = 9999,
		})
		vim.keymap.set("n", "<leader>m", treesj.toggle)
		vim.keymap.set("n", "<leader>M", function()
			treesj.toggle({ split = { recursive = true } })
		end)
	end,
}
