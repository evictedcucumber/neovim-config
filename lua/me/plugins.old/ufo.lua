return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'VeryLazy',
    init = function()
        vim.o.foldcolumn = '0'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    config = function()
        local ufo = require('ufo')

        ufo.setup()

        vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
        vim.keymap.set(
            'n',
            'zM',
            ufo.closeAllFolds,
            { desc = 'Close All Folds' }
        )
    end,
}
