local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['tsserver'] = { 'javascript', 'typescript', 'svelte' },
        ['svelte'] = { 'svelte' },
        ['rust_analyzer'] = { 'rust' },
        ['gopls'] = { 'go' },
        ['lua_ls'] = { 'lua' },
        ['pyright'] = { 'python' },
    }
})
require('lspconfig').rust_analyzer.setup({
    on_attach = lsp_zero.on_attach,
    settings = {
        ['rust-analyzer'] = {

            diagnostics = {
                enable = true,
                enableExperimental = true,
            },
            -- checkOnSave = true,
            cargo = {
                buildScripts = {
                    enable = true
                },
            },
            procMacro = {
                enable = true
            },
        },

        ["pyright"] = {
            settings = {
                pyright = { autoImportCompletion = true, },
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = 'openFilesOnly',
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = 'off'
                    }
                }
            }
        }
    }
})

require('lspconfig').tailwindcss.setup({
    on_attach = lsp_zero.on_attach,
})


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'rust_analyzer', 'gopls', 'pyright', 'tailwindcss' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})



local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Add this line
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
