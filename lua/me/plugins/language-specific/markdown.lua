return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.icons',
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            preset = 'obsidian',
            completions = { blink = { enabled = true } },
        },
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
        build = 'cd app && yarn install',
        ft = { 'markdown' },
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
            vim.g.mkdp_port = '8080'
            vim.g.mkdp_open_ip = '0.0.0.0'
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_theme = 'dark'
        end,
    },
    {
        'obsidian-nvim/obsidian.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
        event = {
            'BufReadPre ' .. vim.fn.expand('~') .. '/myvault/**/*.md',
            'BufNewFile ' .. vim.fn.expand('~') .. '/myvault/**/*.md',
        },
        opts = {
            -- TODO: Remove when plugin goes to 4.0
            legacy_commands = false,
            workspaces = {
                {
                    name = 'myvault',
                    path = '~/myvault',
                },
            },
            completion = { nvim_cmp = false, blink = true },
            new_notes_dir = 'current_dir',
            picker = { name = 'snacks.pick' },
            ui = { enable = false },
        },
    },
}
