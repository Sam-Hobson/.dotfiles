function ColorMyPencils( colourOrTheme )
	vim.cmd.colorscheme(colourOrTheme)
end


function RosepineColour()

    require("rose-pine").setup({
        disable_background = true
    })

    ColorMyPencils("rose-pine")

end


function GruvboxColour()

    require("gruvbox").setup({
        transparent_mode = true
    })

    ColorMyPencils("gruvbox")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "Visual", { bg = "#2b2b2b" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1b1b1b" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#1b1b1b" })
	vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2b2b2b" })

end


GruvboxColour()

