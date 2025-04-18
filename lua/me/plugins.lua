return {
    -- globals
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    { 'echasnovski/mini.icons', version = '*', opts = {} },
    -- /globals
    -- colourscheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        init = function()
            vim.cmd('colorscheme catppuccin')
        end,
        opts = {
            flavour = 'mocha',
            background = { dark = 'mocha' },
            show_end_of_buffer = true,
            default_integrations = true,
            integrations = {
                which_key = true,
                gitsigns = true,
                treesitter = true,
                mini = { enabled = true },
                blink_cmp = true,
                harpoon = true,
                noice = true,
                native_lsp = {
                    enabled = true,
                    inlay_hint = { background = true },
                },
                notify = true,
                snacks = {
                    enabled = true,
                    indent_scope_color = 'lavender',
                },
                lsp_trouble = true,
            },
            custom_highlights = function(colors)
                return {
                    NormalFloat = { fg = colors.text, bg = colors.none },
                    Pmenu = { link = 'NormalFloat' },
                    FloatBorder = { link = 'NormalFloat' },
                }
            end,
        },
    },
    -- /colourscheme
    -- notifications
    {
        'folke/noice.nvim',
        dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
        event = 'VeryLazy',
        opts = {
            cmdline = { view = 'cmdline' },
            routes = {
                {
                    filter = {
                        event = 'notify',
                        find = 'No information available',
                    },
                    opts = { skip = true },
                },
            },
            lsp = {
                hover = { enabled = true },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                },
            },
            signature = { enabled = false },
            messages = {
                enabled = true,
                view = 'mini',
                view_error = 'mini',
                view_warn = 'mini',
            },
            presets = { lsp_doc_border = true },
        },
    },
    -- /notifications
    -- completion
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        dependencies = { 'rafamadriz/friendly-snippets' },
    },
    {
        'saghen/blink.cmp',
        build = 'cargo build --release',
        dependencies = { 'LuaSnip', 'nvim-lspconfig' },
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
            require('me.configs.blink')
        end,
    },
    -- /completion
    -- lsp
    {
        'neovim/nvim-lspconfig',
        event = { 'BufNewFile', 'BufReadPost' },
        config = function()
            require('me.configs.lsp')
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        keys = {
            {
                '<leader>t',
                '<cmd>Trouble diagnostics toggle<CR>',
                desc = 'Trouble Toggle',
            },
            {
                '[t',
                '<cmd>Trouble prev<CR>',
                desc = 'Previous Trouble Diagnostic',
            },
            { ']t', '<cmd>Trouble next<CR>', desc = 'Next Trouble Diagnostic' },
            {
                '[T',
                '<cmd>Trouble first<CR>',
                desc = 'First Trouble Diagnostic',
            },
            { ']T', '<cmd>Trouble last<CR>', desc = 'Last Trouble Diagnostic' },
        },
        opts = {},
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { 'snacks.nvim' } },
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
        keys = {
            {
                '<leader>fm',
                function()
                    require('conform').format({
                        async = true,
                        timeout_ms = 3000,
                        lsp_format = 'fallback',
                    })
                end,
                desc = 'Format current buffer',
            },
        },
        config = function()
            local conform = require('conform')
            conform.setup({})

            local setup_formatter = function(language)
                require('me.configs.languages.' .. language).formatter(
                    conform.formatters_by_ft
                )
            end

            setup_formatter('lua')
        end,
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    -- /conform
    -- lint
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')

            local setup_linter = function(language)
                require('me.configs.languages.' .. language).linter(
                    lint.linters_by_ft
                )
            end

            setup_linter('lua')

            vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
                group = Me.custom_augroup('Lint'),
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
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
        'echasnovski/mini.cursorword',
        version = '*',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {},
    },
    -- /mini
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'noice.nvim' },
        event = 'VimEnter',
        config = function()
            local showmode = require('noice').api.status.mode
            require('lualine').setup({
                options = { theme = 'catppuccin' },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = { 'filename' },
                    lualine_x = {
                        ---@diagnostic disable-next-line:undefined-field
                        { showmode.get, cond = showmode.has },
                        'lsp_status',
                    },
                    lualine_y = { 'filetype' },
                    lualine_z = { 'location' },
                },
            })
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
    -- whichkey
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            preset = 'helix',
            win = {
                wo = {
                    winblend = 100,
                },
            },
        },
    },
    -- /whichkey
    -- yazi
    {
        'mikavilpas/yazi.nvim',
        dependencies = { 'snacks.nvim' },
        event = { 'VeryLazy' },
        keys = {
            { '-', '<CMD>Yazi cwd<CR>', desc = 'Open Yazi in CWD' },
            { '_', '<CMD>Yazi<CR>', desc = 'Open Yazi at current file' },
        },
        opts = { open_for_directories = true },
        init = function()
            vim.g.loaded_netrwPlugin = 1
        end,
    },
    -- /yazi
}
