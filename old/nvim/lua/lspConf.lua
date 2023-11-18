-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>cc", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "]e", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "[e", vim.diagnostic.goto_next, opts)

local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	-- capabilities = require('cmp_nvim_lsp').update_capabilities(
	--   vim.lsp.protocol.make_client_capabilities()
	-- ),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

		-- Enable completion triggered by <c-x><c-o>
		-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		-- vim.keymap.set("n", "<space>wl", function()
		-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, bufopts)
		vim.keymap.set("n", "D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		-- vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
	end,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

---
-- LSP Servers
---

lspconfig.pyright.setup({
  capabilities = capabilities
})

lspconfig.clangd.setup({
  capabilities = capabilities
})
lspconfig.tsserver.setup({
  capabilities = capabilities
})
lspconfig.hls.setup({
  capabilities = capabilities
})
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.bashls.setup({
  capabilities = capabilities
})

lspconfig.html.setup({
  capabilities = capabilities
})

lspconfig.vimls.setup({
  capabilities = capabilities
})
lspconfig.sqlls.setup({
  capabilities = capabilities
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				allFeatures = true,
				overrideCommand = {
					"cargo",
					"clippy",
					"--workspace",
					"--message-format=json",
					"--all-targets",
					"--all-features",
				},
			},
		},
	},
})

lspconfig.phpactor.setup({})
