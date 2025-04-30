local M = { 'folke/trouble.nvim' }

M.cmd = 'Trouble'
M.keys = {
    {
        '<leader>t',
        '<cmd>Trouble diagnostics toggle<CR>',
        desc = 'Trouble Toggle',
    },
    { '[t', '<cmd>Trouble prev<CR>', desc = 'Troule Previous' },
    { ']t', '<cmd>Trouble next<CR>', desc = 'Trouble Next' },
}

M.opts = {}

return M
