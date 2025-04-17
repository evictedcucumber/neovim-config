local exclude = {
    '**/*.lock',
    '**/build/',
    '**/.cache/',
    '**/target/',
}

require('snacks').setup({
    dashboard = require('me.configs.snacks.dashboard'),
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
    indent = {
        animate = { enabled = false },
        scope = { hl = 'SnacksIndent6' },
    },
    quickfile = { enabled = true },
    input = { enabled = true },
})

vim.keymap.set('n', '<leader>sf', function()
    Snacks.picker.files()
end, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sg', function()
    Snacks.picker.grep()
end, { desc = 'Search with Grep' })
vim.keymap.set('n', '<leader>sb', function()
    Snacks.picker.buffers({
        current = false,
        sort_lastused = true,
    })
end, { desc = 'Search Buffers' })
vim.keymap.set('n', '<leader>ss', function()
    Snacks.picker.spelling()
end, { desc = 'Spell Suggest' })
