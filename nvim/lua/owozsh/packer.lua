vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        { run = ':TSUpdate' }
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { { 'nvim-lua/plenary.nvim' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }
    use { 'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim' }
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'
    use { 'mg979/vim-visual-multi', branch = 'master' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
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
    use 'romgrk/barbar.nvim'
    use 'folke/tokyonight.nvim'
    use "rebelot/kanagawa.nvim"
    use 'sam4llis/nvim-tundra'
    use 'Mofiqul/dracula.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'ishan9299/nvim-solarized-lua'
    use "EdenEast/nightfox.nvim"
    use 'navarasu/onedark.nvim'
    use 'Shatur/neovim-ayu'
    use 'loctvl842/monokai-pro.nvim'
    use 'gbprod/nord.nvim'
    use 'AlexvZyl/nordic.nvim'
    use {
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim"
    }
    use { "ellisonleao/gruvbox.nvim" }
    use {
        'olivercederborg/poimandres.nvim',
        config = function()
            require('poimandres').setup {
                -- leave this setup function empty for default config
                -- or refer to the configuration section
                -- for configuration options
            }
        end
    }

    use 'dhruvasagar/vim-table-mode'
    use "rafamadriz/friendly-snippets"
    use 'saadparwaiz1/cmp_luasnip'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use "lukas-reineke/indent-blankline.nvim"
    use 'windwp/nvim-ts-autotag'
    use 'norcalli/nvim-colorizer.lua'
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use "tpope/vim-surround"
    use 'tpope/vim-commentary'
    use 'sainnhe/everforest'
    use 'sainnhe/gruvbox-material'
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
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'junegunn/goyo.vim'
end)
