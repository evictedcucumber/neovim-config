require('snacks').setup({
    picker = {
        layout = {
            preset = 'ivy',
        },
        matcher = {
            cwd_bonus = true,
            frecency = true,
        },
    },
})

vim.keymap.set('n', '<leader>sf', function()
    Snacks.picker.files({
        hidden = true,
    })
end, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sb', function()
    Snacks.picker.buffers({
        current = false,
        sort_lastused = true,
        hidden = true,
    })
end, { desc = 'Search Buffers' })
vim.keymap.set('n', '<leader>sg', function()
    Snacks.picker.grep({
        hidden = true,
    })
end, { desc = 'Search with Grep' })
vim.keymap.set('n', '<leader>ss', function()
    Snacks.picker.spelling()
end, { desc = 'Spell Suggest' })
