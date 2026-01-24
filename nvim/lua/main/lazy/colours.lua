return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		enabled = false,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})

			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"vague2k/vague.nvim",
		enabled = false,
		config = function()
			require("vague").setup({
				transparent = true,
			})
			vim.cmd("colorscheme vague")
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RGBA = true, -- #RGBA hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				oklch_fn = true, -- CSS oklch() function
				css = true, -- Enable all CSS *features*:
				-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn, oklch_fn
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn, oklch_fn
				-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
				tailwind = true, -- Enable tailwind colors
				tailwind_opts = { -- Options for highlighting tailwind names
					update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
				},
				-- parsers can contain values used in `user_default_options`
				sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
				xterm = false, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
				-- Highlighting mode.  'background'|'foreground'|'virtualtext'
				mode = "background", -- Set the display mode
				-- Virtualtext character to use
				virtualtext = "■",
				-- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
				virtualtext_inline = true,
				-- Virtualtext highlight mode: 'background'|'foreground'
				virtualtext_mode = "foreground",
				-- update color values even if buffer is not focused
				-- example use: cmp_menu, cmp_docs
				always_update = false,
				-- hooks to invert control of colorizer
				hooks = {
					-- called before line parsing.  Accepts boolean or function that returns boolean
					-- see hooks section below
					disable_line_highlight = false,
				},
			},
		},
	},
}
