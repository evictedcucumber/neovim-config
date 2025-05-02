local M = { 'folke/flash.nvim' }

M.event = 'VeryLazy'
M.keys = {
    {
        's',
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
}

M.opts = {}

return M
