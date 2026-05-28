if not _G.pack_wrapper.add('ledger', 'vim-ledger', { requireable = false }) then
    return
end

vim.g.ledger_bin = 'hledger'

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'ledger',
    callback = function()
        _G.keymap(
            'n',
            '<leader>la',
            '<cmd>call ledger#align_commodity_buffer',
            { desc = 'Align Ledger Commodities' }
        )
    end,
})
