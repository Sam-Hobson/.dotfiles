return {
	"nguyenvukhang/nvim-toggler",
	event = "VeryLazy",
	config = function()
		require("nvim-toggler").setup({
			-- your own inverses
			inverses = {
				["true"] = "false",
				["True"] = "False",
				["yes"] = "no",
				["Yes"] = "No",
				["on"] = "off",
				["On"] = "Off",
				["left"] = "right",
				["Left"] = "Right",
				["up"] = "down",
				["Up"] = "Down",
				["enable"] = "disable",
				["Enable"] = "Disable",
			},
			-- removes the default <leader>i keymap
			remove_default_keybinds = false,
			-- removes the default set of inverses
			remove_default_inverses = true,
			-- auto-selects the longest match when there are multiple matches
			autoselect_longest_match = false,
		})
	end,
}
