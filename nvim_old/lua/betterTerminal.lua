local betterTerm = require("betterTerm")
-- Create new term
local current = 2
vim.keymap.set({ "n" }, "<leader>Tn", function()
	betterTerm.open(current)
	current = current + 1
end, { desc = "New terminal" })

betterTerm.setup({
	prefix = "t",
  startInserted = false,
	position = "bot",
	size = 18,
})

vim.keymap.set("n", "<leader>e", function()
	require("betterTerm").send(require("code_runner.commands").get_filetype_command(), 1, {clean = true, interrupt = true})
end, { desc = "Execute File" })
