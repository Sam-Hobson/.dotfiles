return {
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({
				auto_cmd = false, -- Set to false to disable automatic execution
				override_editorconfig = false, -- Set to true to override settings set by .editorconfig
				filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
					"netrw",
					"tutor",
				},
				buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
					"help",
					"nofile",
					"terminal",
					"prompt",
				},
				on_tab_options = { -- A table of vim options when tabs are detected
					["expandtab"] = false,
				},
				on_space_options = { -- A table of vim options when spaces are detected
					["expandtab"] = true,
					["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
					["softtabstop"] = "detected",
					["shiftwidth"] = "detected",
				},
			})

			vim.keymap.set("n", "<leader>I", "<cmd>GuessIndent<CR>")
		end,
	},
	{
		"Mr-LLLLL/cool-chunk.nvim",
		event = { "CursorHold", "CursorHoldI" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local cursorLineNrHl = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
			vim.api.nvim_set_hl(0, "CoolChunkTransparent", {
				fg = cursorLineNrHl.fg,
				bg = "NONE",
			})

			require("cool-chunk").setup({
				chunk = {
					hl_group = {
						chunk = "CoolChunkTransparent",
						error = "CoolChunkTransparent",
					},
					animate_duration = 0, -- if don't want to animation, set to 0.
				},
				line_num = {
					enable = false,
				},
			})
		end,
	},
}
