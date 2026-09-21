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
			-- gopls and the Go formatters shell out to `go`, but nvim inherits a
			-- PATH without one: mise isn't activated in the shell. `mise which`
			-- walks the config cascade from a directory, so a project's pinned
			-- toolchain wins and the mise global comes next. When mise resolves
			-- nothing, leave PATH alone and use the globally installed Go.
			local function path_with_go(dir)
				if vim.fn.executable("mise") == 0 then
					return vim.env.PATH
				end
				local res = vim.system({ "mise", "which", "go" }, { cwd = dir, text = true }):wait(5000)
				if res.code ~= 0 then
					return vim.env.PATH
				end
				return vim.fs.dirname(vim.trim(res.stdout)) .. ":" .. vim.env.PATH
			end

			-- Mason builds gopls with `go install` and conform runs gofmt, both out
			-- of nvim's own environment.
			vim.env.PATH = path_with_go(vim.uv.cwd())

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls" },
			})
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
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "[e", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]e", vim.diagnostic.goto_prev, opts)
				end,
			})

			-- Vue TypeScript plugin path (Mason)
			local vue_language_server_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = vue_language_server_path,
									languages = { "vue" },
									configNamespace = "typescript",
								},
							},
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			vim.lsp.config("vue_ls", {})

			-- Resolve Go per project root rather than once at startup, since one
			-- nvim can serve several projects that each pin their own toolchain.
			-- The mise shims can't do this: they hard-error rather than fall
			-- through when a project has no mise-managed Go.
			vim.lsp.config("gopls", {
				cmd = function(dispatchers, config)
					local root = config.root_dir or vim.uv.cwd()
					return vim.lsp.rpc.start({ "gopls" }, dispatchers, {
						cwd = root,
						env = { PATH = path_with_go(root) },
					})
				end,
			})

			vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
		end,
	},
}
