return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
        {
            '<leader>S',
            function()
                require('flash').jump()
            end,
            mode = { 'n', 'x', 'o' },
            desc = 'Flash',
        },
        {
            'r',
            function()
                require('flash').remote()
            end,
            mode = 'o',
            desc = 'Flash Remote',
        },
        {
            '<C-s>',
            function()
                require('flash').toggle()
            end,
            mode = 'o',
            desc = 'Flash Toggle',
        },
    },

    opts = {},
}
