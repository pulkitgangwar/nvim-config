-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- file explorer
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- color scheme
    use 'folke/tokyonight.nvim'


    -- treesitter(syntax highlighting, indenting, blazingly fast)
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    -- undotree
    use 'mbbill/undotree'

    -- lsp, snippets, autocomplete
    use {
        'VonHeikemen/lsp-zero.nvim',
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

    -- movement between splits
    use "christoomey/vim-tmux-navigator"

    -- makes commenting easierj
    use "numToStr/Comment.nvim"

    -- buffer line support
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"


    -- clipboard manager
    use "AckslD/nvim-neoclip.lua"

    -- toggle terminal
    use "akinsho/toggleterm.nvim"

    -- auto pairs
    use "windwp/nvim-autopairs"

    -- bottom informative line
    use 'nvim-lualine/lualine.nvim'






end)
