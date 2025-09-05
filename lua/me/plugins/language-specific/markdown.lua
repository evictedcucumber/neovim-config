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
            completions = { lsp = { enabled = true } },
        },
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
