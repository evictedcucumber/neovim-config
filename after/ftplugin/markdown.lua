vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.colorcolumn = ''
vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.signcolumn = 'no'

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.keymap.set(
    { 'n', 'x', 'o' },
    'j',
    'gj',
    { buffer = true, noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    'k',
    'gk',
    { buffer = true, noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    '0',
    'g0',
    { buffer = true, noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    '^',
    'g^',
    { buffer = true, noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    '$',
    'g$',
    { buffer = true, noremap = true, silent = true }
)
