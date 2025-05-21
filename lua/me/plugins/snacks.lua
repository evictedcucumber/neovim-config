return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
        {
            '<leader>sf',
            function()
                require('snacks').picker.files()
            end,
            desc = '[S]earch [F]iles',
        },
        {
            '<leader>sg',
            function()
                require('snacks').picker.grep()
            end,
            desc = '[S]earch [G]rep',
        },
        {
            '<leader>sd',
            function()
                require('snacks').picker.diagnostics_buffer()
            end,
            desc = '[S]earch Buffer [D]iagnostics',
        },
        {
            '<leader>sD',
            function()
                require('snacks').picker.diagnostics()
            end,
            desc = '[S]earch Project [D]iagnostics',
        },
        {
            '<leader>sh',
            function()
                require('snacks').picker.help()
            end,
            desc = '[S]earch [H]elp',
        },
        {
            '<leader>sk',
            function()
                require('snacks').picker.keymaps()
            end,
            desc = '[S]earch [K]eymaps',
        },
    },
    config = function()
        local exclude = {
            '**/*.lock',
            '**/build/',
            '**/.cache/',
            '**/target/',
        }

        require('snacks').setup({
            picker = {
                layout = { preset = 'ivy' },
                matcher = {
                    cwd_bonus = true,
                    frecency = true,
                },
                sources = {
                    grep = {
                        hidden = true,
                        exclude = exclude,
                    },
                    files = {
                        hidden = true,
                        exclude = exclude,
                    },
                },
            },
            indent = { animate = { enabled = false } },
            quickfile = { enabled = true },
            input = { enabled = true },
        })
    end,
}
