vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- essentials
    use 'wbthomason/packer.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        { run = ':TSUpdate' }
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'mbbill/undotree'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                config = function()
                    require 'cmp'.setup {
                        snippet = {
                            expand = function(args)
                                require 'luasnip'.lsp_expand(args.body)
                            end
                        },

                        sources = {
                            { name = 'luasnip' },
                        },
                    }
                end
            }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }
    use {
        'stevearc/conform.nvim',
        config = function() require('conform').setup() end
    }

    -- themes
    use "ellisonleao/gruvbox.nvim"
    use 'Mofiqul/dracula.nvim'
    use 'folke/tokyonight.nvim'
    use 'navarasu/onedark.nvim'
    use "rebelot/kanagawa.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'owozsh/amora'
    use 'maxmx03/solarized.nvim'


    use 'dhruvasagar/vim-table-mode'
    use "rafamadriz/friendly-snippets"
    use 'saadparwaiz1/cmp_luasnip'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use 'windwp/nvim-ts-autotag'
    use 'norcalli/nvim-colorizer.lua'
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use "tpope/vim-surround"
    use 'tpope/vim-commentary'
    use 'sainnhe/everforest'
    use 'f-person/auto-dark-mode.nvim'
    use {
        "Pocco81/true-zen.nvim",
        config = function()
            require("true-zen").setup {
                -- your config goes here
                -- or just leave it empty :)
            }
        end,
    }
end)
