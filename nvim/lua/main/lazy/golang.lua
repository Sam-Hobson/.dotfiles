return {
	{
		"maxandron/goplements.nvim",
		ft = "go",
		config = function()
			require("goplements").setup()
		end,
	},
	{
		"crusj/hierarchy-tree-go.nvim",
		ft = "go",
		config = function()
			require("hierarchy-tree-go").setup({
				icon = {
					fold = ">", -- fold icon
					unfold = "v", -- unfold icon
					func = "F", -- symbol
					last = "☉", -- last level icon
				},
				hl = {
					current_module = "guifg=Green", -- highlight cwd module line
					others_module = "guifg=Orange", -- highlight others module line
					cursorline = "guibg=Gray guifg=White", -- hl  window cursorline
				},
				keymap = {
					--global keymap
					incoming = "<leader>gi", -- call incoming under cursorword
					outgoing = "<leader>go", -- call outgoing under cursorword
					open = "<leader>gO", -- open hierarchy win
					close = "<leader>gq", -- close hierarchy win
					-- focus: if hierarchy win is valid but is not current win, set to current win
					-- focus: if hierarchy win is valid and is current win, close
					-- focus  if hierarchy win not existing,open and focus
					focus = "<leader>gg",

					-- bufkeymap
					expand = "<CR>", -- expand or collapse hierarchy
					jump = "o", -- jump
					move = "<leader>gw", -- switch the hierarchy window position, must be current win
				},
			})
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			lsp_keymaps = false,
		},
		config = function(lp, opts)
			require("go").setup(opts)
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
