require('nvim-toggler').setup({
	-- your own inverses
	inverses = {
		['true'] = 'false',
		['True'] = 'False',
		['yes'] = 'no',
		['on'] = 'off',
		['left'] = 'right',
		['up'] = 'down',
		['enable'] = 'disable',
		['!='] = '==',
		['in'] = 'not in',
		['<='] = '>=',
		['<'] = '>',
	},
	-- removes the default <leader>i keymap
	remove_default_keybinds = false,
	-- removes the default set of inverses
	remove_default_inverses = true,
	-- auto-selects the longest match when there are multiple matches
	autoselect_longest_match = false
})
