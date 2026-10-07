vim.wo[0][0].wrap = true
vim.wo[0][0].linebreak = true
vim.wo[0][0].colorcolumn = ''
vim.wo[0][0].number = false
vim.wo[0][0].relativenumber = false
vim.wo[0][0].signcolumn = 'no'

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
