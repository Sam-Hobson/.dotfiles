return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("fidget").setup({})

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("i", "<C-k>", function()
						vim.lsp.buf.signature_help({ border = "rounded" })
					end, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>cc", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
				end,
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
		end,
	},
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	enabled = false, -- This is an old config
	-- 	dependencies = {
	-- 		"stevearc/conform.nvim",
	-- 		"williamboman/mason.nvim",
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-cmdline",
	-- 		"hrsh7th/nvim-cmp",
	-- 		"L3MON4D3/LuaSnip",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"j-hui/fidget.nvim",
	-- 	},
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		local cmp_lsp = require("cmp_nvim_lsp")
	-- 		local capabilities = vim.tbl_deep_extend(
	-- 			"force",
	-- 			{},
	-- 			vim.lsp.protocol.make_client_capabilities(),
	-- 			cmp_lsp.default_capabilities()
	-- 		)
	--
	-- 		require("fidget").setup({})
	-- 		require("mason").setup()
	-- 		require("mason-lspconfig").setup({
	-- 			ensure_installed = {
	-- 				"lua_ls",
	-- 				"vtsls",
	-- 				"vue_ls",
	-- 			},
	-- 			handlers = {
	-- 				function(server_name) -- default handler (optional)
	-- 					require("lspconfig")[server_name].setup({
	-- 						capabilities = capabilities,
	-- 					})
	-- 				end,
	--
	-- 				zls = function()
	-- 					local lspconfig = require("lspconfig")
	-- 					lspconfig.zls.setup({
	-- 						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
	-- 						settings = {
	-- 							zls = {
	-- 								enable_inlay_hints = true,
	-- 								enable_snippets = true,
	-- 								warn_style = true,
	-- 							},
	-- 						},
	-- 					})
	-- 					vim.g.zig_fmt_parse_errors = 0
	-- 					vim.g.zig_fmt_autosave = 0
	-- 				end,
	-- 				["lua_ls"] = function()
	-- 					local lspconfig = require("lspconfig")
	-- 					lspconfig.lua_ls.setup({
	-- 						capabilities = capabilities,
	-- 						settings = {
	-- 							Lua = {
	-- 								format = {
	-- 									enable = true,
	-- 									defaultConfig = {
	-- 										indent_style = "space",
	-- 										indent_size = "2",
	-- 									},
	-- 								},
	-- 							},
	-- 						},
	-- 					})
	-- 				end,
	-- 				["gopls"] = function()
	-- 					local lspconfig = require("lspconfig")
	-- 					lspconfig.gopls.setup({
	-- 						settings = {
	-- 							gopls = {
	-- 								-- gofumpt = true,
	-- 								staticcheck = true,
	-- 								completeUnimported = true,
	-- 								usePlaceholders = true,
	-- 								analyses = {
	-- 									unusedparams = true,
	-- 								},
	-- 							},
	-- 						},
	-- 					})
	-- 				end,
	-- 				-- vtsls = function()
	-- 				-- 	local lspconfig = require("lspconfig")
	-- 				-- 	local mason_registry = require("mason-registry")
	-- 				-- 	local vue_language_server_path = mason_registry
	-- 				-- 		.get_package("vue-language-server")
	-- 				-- 		:get_install_path() .. "/node_modules/@vue/language-server"
	-- 				-- 	lspconfig.vtsls.setup({
	-- 				-- 		settings = {
	-- 				-- 			vtsls = {
	-- 				-- 				tsserver = {
	-- 				-- 					globalPlugins = {
	-- 				-- 						{
	-- 				-- 							name = "@vue/typescript-plugin",
	-- 				-- 							location = vue_language_server_path,
	-- 				-- 							languages = { "vue" },
	-- 				-- 							configNamespace = "typescript",
	-- 				-- 						},
	-- 				-- 					},
	-- 				-- 				},
	-- 				-- 			},
	-- 				-- 		},
	-- 				-- 		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	-- 				-- 	})
	-- 				-- end,
	-- 				-- vue_ls = function()
	-- 				-- 	local lspconfig = require("lspconfig")
	-- 				-- 	lspconfig.vue_ls.setup({
	-- 				-- 		on_init = function(client)
	-- 				-- 			client.handlers["tsserver/request"] = function(_, result, context)
	-- 				-- 				local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
	-- 				-- 				if #clients == 0 then
	-- 				-- 					vim.notify(
	-- 				-- 						"Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
	-- 				-- 						vim.log.levels.ERROR
	-- 				-- 					)
	-- 				-- 					return
	-- 				-- 				end
	-- 				-- 				local ts_client = clients[1]
	-- 				--
	-- 				-- 				local param = unpack(result)
	-- 				-- 				local id, command, payload = unpack(param)
	-- 				-- 				ts_client:exec_cmd({
	-- 				-- 					title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
	-- 				-- 					command = "typescript.tsserverRequest",
	-- 				-- 					arguments = {
	-- 				-- 						command,
	-- 				-- 						payload,
	-- 				-- 					},
	-- 				-- 				}, { bufnr = context.bufnr }, function(_, r)
	-- 				-- 					local response_data = { { id, r.body } }
	-- 				-- 					---@diagnostic disable-next-line: param-type-mismatch
	-- 				-- 					client:notify("tsserver/response", response_data)
	-- 				-- 				end)
	-- 				-- 			end
	-- 				-- 		end,
	-- 				-- 	})
	-- 				-- end,
	-- 			},
	-- 		})
	--
	-- 		local mason_registry = require("mason-registry")
	-- 		-- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
	-- 		-- 	.. "/node_modules/@vue/language-server"
	--
	-- 		local vue_language_server_path = vim.fn.stdpath("data")
	-- 			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
	--
	-- 		local vue_plugin = {
	-- 			name = "@vue/typescript-plugin",
	-- 			location = vue_language_server_path,
	-- 			languages = { "vue" },
	-- 			configNamespace = "typescript",
	-- 		}
	-- 		local vtsls_config = {
	-- 			settings = {
	-- 				vtsls = {
	-- 					tsserver = {
	-- 						globalPlugins = {
	-- 							vue_plugin,
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	-- 		}
	--
	-- 		-- local vue_ls_config = {
	-- 		-- 	on_init = function(client)
	-- 		-- 		client.handlers["tsserver/request"] = function(_, result, context)
	-- 		-- 			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
	-- 		-- 			if #clients == 0 then
	-- 		-- 				vim.notify(
	-- 		-- 					"Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
	-- 		-- 					vim.log.levels.ERROR
	-- 		-- 				)
	-- 		-- 				return
	-- 		-- 			end
	-- 		-- 			local ts_client = clients[1]
	-- 		--
	-- 		-- 			local param = unpack(result)
	-- 		-- 			local id, command, payload = unpack(param)
	-- 		-- 			ts_client:exec_cmd({
	-- 		-- 				title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
	-- 		-- 				command = "typescript.tsserverRequest",
	-- 		-- 				arguments = {
	-- 		-- 					command,
	-- 		-- 					payload,
	-- 		-- 				},
	-- 		-- 			}, { bufnr = context.bufnr }, function(_, r)
	-- 		-- 				local response_data = { { id, r.body } }
	-- 		-- 				---@diagnostic disable-next-line: param-type-mismatch
	-- 		-- 				client:notify("tsserver/response", response_data)
	-- 		-- 			end)
	-- 		-- 		end
	-- 		-- 	end,
	-- 		-- }
	-- 		-- nvim 0.11 or above
	-- 		vim.lsp.config("vtsls", vtsls_config)
	-- 		-- vim.lsp.config("vue_ls", vue_ls_config)
	-- 		vim.lsp.enable({ "vtsls", "vue_ls" })
	--
	-- 		local cmp_select = { behavior = cmp.SelectBehavior.Select }
	--
	-- 		cmp.setup({
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					require("luasnip").lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	-- 				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
	-- 				["<CR>"] = cmp.mapping.confirm({ select = false }),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 			}),
	-- 			sources = cmp.config.sources({
	-- 				-- { name = "copilot", group_index = 2 },
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 			}, {
	-- 				{ name = "buffer" },
	-- 				{ name = "path" },
	-- 			}),
	-- 		})
	--
	-- 		vim.diagnostic.config({
	-- 			-- update_in_insert = true,
	-- 			float = {
	-- 				focusable = false,
	-- 				style = "minimal",
	-- 				border = "rounded",
	-- 				source = "always",
	-- 				header = "",
	-- 				prefix = "",
	-- 			},
	-- 		})
	--
	-- 		vim.api.nvim_create_autocmd("LspAttach", {
	-- 			group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	-- 			callback = function(event)
	-- 				local opts = { buffer = event.buf }
	--
	-- 				vim.keymap.set("n", "K", function()
	-- 					vim.lsp.buf.hover({ border = "rounded" })
	-- 				end, opts)
	-- 				vim.keymap.set("n", "<leader>cc", function()
	-- 					vim.diagnostic.open_float()
	-- 				end, opts)
	-- 				vim.keymap.set("n", "[d", function()
	-- 					vim.diagnostic.goto_next()
	-- 				end, opts)
	-- 				vim.keymap.set("n", "]d", function()
	-- 					vim.diagnostic.goto_prev()
	-- 				end, opts)
	-- 				vim.keymap.set("n", "<leader>ca", function()
	-- 					vim.lsp.buf.code_action()
	-- 				end, opts)
	-- 				vim.keymap.set("n", "<leader>cr", function()
	-- 					vim.lsp.buf.rename()
	-- 				end, opts)
	-- 				vim.keymap.set("i", "<C-k>", function()
	-- 					vim.lsp.buf.signature_help({ border = "rounded" })
	-- 				end, opts)
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
