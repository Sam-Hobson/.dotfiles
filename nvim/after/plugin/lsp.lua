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
        tsserver = function()
            local vue_typescript_plugin = require('mason-registry')
                .get_package('vue-language-server')
                :get_install_path()
                .. '/node_modules/@vue/language-server'
                .. '/node_modules/@vue/typescript-plugin'

            lspconfig.tsserver.setup({
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

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
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
})

vim.diagnostic.config({ virtual_text = true })
