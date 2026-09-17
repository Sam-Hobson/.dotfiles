local ensure_installed = {
	"vimdoc",
	"javascript",
	"typescript",
	"c",
	"lua",
	"rust",
	"jsdoc",
	"bash",
	"go",
}

local max_filesize = 100 * 1024

local additional_vim_regex_highlighting = {
	markdown = true,
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup()

			local available
			local function is_available(lang)
				available = available or ts.get_available()
				return vim.tbl_contains(available, lang)
			end

			local function is_installed(lang)
				return vim.tbl_contains(ts.get_installed("parsers"), lang)
			end

			local missing = vim.tbl_filter(function(lang)
				return not is_installed(lang)
			end, ensure_installed)
			if #missing > 0 then
				ts.install(missing)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterStart", {}),
				callback = function(args)
					local buf = args.buf
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang then
						return
					end

					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						vim.notify(
							"File larger than 100KB treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
						return
					end

					local function start()
						if not vim.api.nvim_buf_is_valid(buf) then
							return
						end
						if not pcall(vim.treesitter.start, buf, lang) then
							return
						end

						if additional_vim_regex_highlighting[args.match] then
							vim.bo[buf].syntax = "on"
						end

						if vim.api.nvim_get_current_buf() == buf then
							vim.wo[0][0].foldmethod = "expr"
							vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						end
					end

					if is_installed(lang) then
						start()
					elseif is_available(lang) then
						ts.install({ lang }):await(function(err)
							if not err then
								vim.schedule(start)
							end
						end)
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil,
			})
		end,
	},
}
