return {
    -- globals
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    { 'echasnovski/mini.icons', version = '*', opts = {} },
    -- /globals
    -- colourscheme
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                styles = {
                    transparency = true,
                },
                highlight_groups = {
                    CurSearch = { fg = 'base', bg = 'leaf', inherit = false },
                    Search = { fg = 'text', bg = 'leaf', blend = 20, inherit = false },
                    NotifyBackground = { bg = '#000000', inherit = true },
                },
            })
            vim.cmd('colorscheme rose-pine-main')
        end,
    },
    -- /colourscheme
    -- notifications
    {
        'folke/noice.nvim',
        dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
        event = 'VeryLazy',
        opts = {
            cmdline = {
                view = 'cmdline',
                format = { search_down = { view = 'cmdline' }, search_up = { view = 'cmdline' } },
            },
            routes = {
                {
                    filter = { event = 'notify', find = 'No information available' },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'msg_show', kind = '', find = 'written' },
                    opts = { skip = true },
                },
            },
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            messages = { enabled = true, view = 'mini', view_error = 'mini', view_warn = 'mini' },
            presets = { lsp_doc_border = true },
        },
    },
    -- /notifications
    -- tools
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall' },
        opts = {},
        lazy = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'mason.nvim' },
        opts = {
            automatic_installation = true,
        },
        lazy = true,
    },
    -- /tools
    -- completion
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'make install_jsregexp',
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'LuaSnip',
        },
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
            require('me.configs.cmp')
        end,
    },
    -- /completion
    -- lsp
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'mason-lspconfig.nvim' },
        event = { 'BufNewFile', 'BufReadPre' },
        config = function()
            require('me.configs.lsp')
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        keys = {
            { '<leader>t', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble Toggle' },
            { '[t', '<cmd>Trouble prev<CR>', desc = 'Previous Trouble Diagnostic' },
            { ']t', '<cmd>Trouble next<CR>', desc = 'Next Trouble Diagnostic' },
            { '[T', '<cmd>Trouble first<CR>', desc = 'First Trouble Diagnostic' },
            { ']T', '<cmd>Trouble last<CR>', desc = 'Last Trouble Diagnostic' },
        },
        opts = {},
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {},
    },
    -- /lsp
    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        main = 'nvim-treesitter.configs',
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            auto_install = true,
            sync_install = true,
            ensure_installed = {
                -- required
                'vim',
                'regex',
                'lua',
                'bash',
                'markdown',
                'markdown_inline',
                -- optional
                'cpp',
                'cmake',
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter' },
        event = { 'BufReadPre', 'BufNewFile' },
        opts = { max_lines = 1 },
    },
    -- /treesitter
    -- conform
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        config = function()
            require('me.configs.conform')
        end,
    },
    {
        'zapling/mason-conform.nvim',
        dependencies = { 'mason.nvim', 'conform.nvim' },
        opts = {},
    },
    -- /conform
    -- lint
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('me.configs.lint')
        end,
    },
    {
        'rshkarin/mason-nvim-lint',
        dependencies = { 'mason.nvim', 'nvim-lint' },
        opts = {},
    },
    -- /lint
    -- snacks
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require('me.configs.snacks')
        end,
    },
    -- /snacks
    -- harpoon
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        keys = {
            { '<leader>a' },
            { '<leader>e' },
            { '<leader>1' },
            { '<leader>2' },
            { '<leader>3' },
            { '<leader>4' },
            { '<M-p>' },
            { '<M-n>' },
        },
        config = function()
            require('me.configs.harpoon')
        end,
    },
    -- /harpoon
    -- git
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            signs = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
        },
    },
    -- /git
    -- mini
    {
        'echasnovski/mini.ai',
        version = '*',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {},
    },
    {
        'echasnovski/mini.comment',
        version = '*',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {},
    },
    {
        'echasnovski/mini.move',
        version = '*',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {},
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {},
    },
    {
        'echasnovski/mini.bracketed',
        version = '*',
        event = 'VeryLazy',
        opts = { treesitter = { suffix = '' } },
    },
    {
        'echasnovski/mini.cursorword',
        version = '*',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {},
    },
    {
        'echasnovski/mini.files',
        version = '*',
        keys = { { '-', '<cmd>lua MiniFiles.open()<CR>', desc = 'File explorer' } },
        opts = {},
    },
    -- /mini
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        event = 'VimEnter',
        config = function()
            require('me.configs.lualine')
        end,
    },
    -- /lualine
    -- bufferline
    {
        'akinsho/bufferline.nvim',
        version = '*',
        event = 'VimEnter',
        config = function()
            require('me.configs.bufferline')
        end,
    },
    -- /bufferline
    -- tpipeline
    {
        'vimpostor/vim-tpipeline',
        dependencies = { 'lualine.nvim' },
        lazy = false,
    },
    -- /tpipeline
}
