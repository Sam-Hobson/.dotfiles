-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format and FormatWrite commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		c = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--sort-includes",
						"-i",
						util.escape_path(util.get_current_buffer_file_path()),
					},
				}
			end,
		},

		cpp = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--sort-includes",
						"-i",
						util.escape_path(util.get_current_buffer_file_path()),
					},
				}
			end,
		},

		java = {
			function()
				return {
					exe = "java -jar /home/sam/.config/nvim/google-java-format.jar",
					args = {
						"--replace",
						util.escape_path(util.get_current_buffer_file_path()),
					},
				}
			end,
		},

		html = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		css = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		javascript = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		typescript = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		json = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		xml = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		yaml = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end,
		},

		python = {
			function()
				return {
					exe = "black",
					args = {},
				}
			end,
		},

		haskell = {
			function()
				return {
					exe = "stylish-haskell",
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
