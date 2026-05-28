if not _G.pack_wrapper.add('mikavilpas', 'yazi.nvim') then
    return
end

require('yazi').setup({ open_for_directories = true })

_G.keymap('n', '-', '<cmd>Yazi<CR>', { desc = 'Open Yazi at Current File' })
_G.keymap(
    'n',
    '_',
    '<cmd>Yazi cwd<CR>',
    { desc = 'Open Yazi at Current Working Directory' }
)
