-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- plenary
    use('nvim-lua/plenary.nvim')

    -- teleport
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- color scheme
    use {
        'tanvirtin/monokai.nvim',
        as = 'monokai',
        config = function()
            vim.cmd('colorscheme monokai')
        end
    }

    -- tree sitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-textobjects')
    use({
        'nvim-treesitter/playground',
        after = 'nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter'
    })



    -- harpoon
    use('theprimeagen/harpoon')

    -- undotree
    use('mbbill/undotree')

    -- fugitive
    use('tpope/vim-fugitive')

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- surround
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })


    -- copilot
    use("github/copilot.vim")

    -- trouble
    use({
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end
    })

    -- nvim-test
    use {
        "klen/nvim-test",
        config = function()
            require('nvim-test').setup()
        end
    }

    -- zen mode
    use("folke/zen-mode.nvim")

    use("niuiic/core.nvim")

    -- ts
    use("OlegGulevskyy/better-ts-errors.nvim")
    use('MunifTanjim/prettier.nvim')

    -- lisp
    use({
        "monkoose/nvlime",
        requires = {
            { 'monkoose/parsley' },
            { 'hrsh7th/nvim-cmp' },
        }
    })

    -- hardtime - fix bad habits
    use({
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    })
end)
