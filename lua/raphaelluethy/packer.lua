-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}, {"nvim-telescope/telescope-live-grep-args.nvim"}},
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }

    use('onsails/lspkind-nvim')
    -- Visualize lsp progress
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    })
    use('sainnhe/sonokai')

    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    -- See hrsh7th other plugins for more great completion sources!
    -- Snippet engine
    use('hrsh7th/vim-vsnip')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = { -- LSP Support
        {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-nvim-lua'}, -- Snippets
        {'L3MON4D3/LuaSnip'}, {'rafamadriz/friendly-snippets'}}
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")

    -- autoclose brackets
    use('LunarWatcher/auto-pairs')
    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }
    use('lervag/vimtex')
end)

