return {
	"stevearc/conform.nvim",
	opts = {},
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				nix = { "nixfmt" },
				lua = { "stylua" },
			},
		})
	end,
}
