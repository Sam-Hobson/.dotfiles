local function deep_copy(orig)
    local orig_type = type(orig)
    local copy

    if orig_type == 'table' then
        copy = {}
        for key, value in pairs(orig) do
            copy[deep_copy(key)] = deep_copy(value)
        end
        setmetatable(copy, deep_copy(getmetatable(orig)))
    else
        copy = orig
    end

    return copy
end

local lsp = require("lsp-zero")
local ls = require("luasnip")
local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		-- vim.keymap.set("n", "<leader>cs", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>K", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "<leader>cc", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
	end,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			lspconfig[server_name].setup({ capabilities = lsp_capabilities, })
		end,

        -- All this is to get vue-language-server to work
        ts_ls = function()
            local vue_typescript_plugin = require('mason-registry')
                .get_package('vue-language-server')
                :get_install_path()
                .. '/node_modules/@vue/language-server'
                .. '/node_modules/@vue/typescript-plugin'

            lspconfig.ts_ls.setup({
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vue_typescript_plugin,
                            languages = { 'javascript', 'typescript', 'vue' }
                        },
                    }
                },
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'javascript.jsx',
                    'typescript',
                    'typescriptreact',
                    'typescript.tsx',
                    'vue',
                },
            })
        end,

        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' }, },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,

    }
})

local cmp = require('cmp')

local cmp_action = lsp.cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }


local custom_snippets_filetypes = { "go", "robot", "make" }
local snippet_path = vim.fn.stdpath("config") .. "/snippets/"

require('luasnip.loaders.from_vscode').lazy_load({ exclude = custom_snippets_filetypes })
require("luasnip.loaders.from_vscode").lazy_load({ include = custom_snippets_filetypes, paths = { snippet_path } })

sources = {
	{ name = 'path' },
	{ name = 'luasnip', keyword_length = 2 },
	{ name = 'buffer',  keyword_length = 3 },
}

cmp.setup({
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	preselect = cmp.PreselectMode.None,
	sources = deep_copy(sources),
	mapping = cmp.mapping.preset.insert({
		['<Enter>'] = cmp.mapping.confirm({ select = true }),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-l>'] = cmp_action.luasnip_jump_forward(),
		['<C-j>'] = cmp_action.luasnip_jump_backward(),
	}),
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
	experimental = {
		ghost_text = true,
	},
})

vim.diagnostic.config({ virtual_text = true })

local lsp_enabled = false
function toggle_lsp_source()
    lsp_enabled = not lsp_enabled

    local new_sources = deep_copy(sources)
    if lsp_enabled then
        table.insert(new_sources, { name = 'nvim_lsp' })
    end

    cmp.setup({ sources = new_sources })

    print("LSP Completion: " .. (lsp_enabled and "Enabled" or "Disabled"))
end

vim.api.nvim_set_keymap("n", "<leader>ct", "<cmd>lua toggle_lsp_source()<CR>", { noremap = true, silent = true })
