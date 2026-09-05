local pack = require('pack')

if not pack.add('ledger', 'vim-ledger', { requireable = false }) then
    return
end

vim.g.ledger_bin = 'hledger'

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'ledger',
    callback = function()
        vim.keymap.set(
            'n',
            '<leader>la',
            '<cmd>call ledger#align_commodity_buffer()<CR>',
            { desc = 'Align Ledger Commodities' }
        )
    end,
})
