if not _G.pack_wrapper.add('folke', 'snacks.nvim') then
    return
end

local exclude = {
    '**/*.lock',
    '**/build/',
    '**/.cache/',
    '**/target/',
    '**/docs/',
    '**/doc/api/',
    '**/.trash/',
    '**/.direnv/',
}
require('snacks').setup({
    picker = {
        layout = { preset = 'ivy' },
        matcher = { cwd_bonus = true, frecency = true },
        sources = {
            grep = { hidden = true, exclude = exclude },
            files = { hidden = true, exclude = exclude },
        },
    },
    indent = { animate = { enabled = false } },
    quickfile = { enabled = true },
    input = { enabled = true },
    image = { enabled = true },
})
_G.keymap('n', '<leader>sf', function()
    require('snacks').picker.files()
end, { desc = '[S]earch [F]iles' })
_G.keymap('n', '<leader>sg', function()
    require('snacks').picker.grep()
end, { desc = '[S]earch [G]rep' })
_G.keymap('n', '<leader>sh', function()
    require('snacks').picker.help()
end, { desc = '[S]earch [H]elp' })
_G.keymap('n', '<leader>sk', function()
    require('snacks').picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })
_G.keymap('n', '<leader>sb', function()
    require('snacks').picker.buffers()
end, { desc = '[S]earch [B]uffers' })
