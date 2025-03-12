vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- quick leave insert mode
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Quick Leave Insert Mode' })

-- yank and paste
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to Clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from Clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank Line to Clipboard' })

-- keep cursor in centre of window
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- bring line below up
vim.keymap.set('n', 'J', 'mzJ`z')
