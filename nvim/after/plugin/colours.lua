
function ColorMyPencils( colourOrTheme )
	vim.cmd.colorscheme(colourOrTheme)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

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

end


GruvboxColour()

