-- center search results
vim.keymap.set('n', 'n', 'nzzzv', { desc = '[N]ext Search Result' }) -- center screen to next search result
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous Search Result' }) -- center screen to previous search result

-- center half-page scroll
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll [D]own Half-Page' }) -- scroll down half-page centered
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll [U]p Half-Page' }) -- scroll up half-page centered

-- better visual mode indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Ident Left' }) -- indent left and reselect
vim.keymap.set('v', '>', '>gv', { desc = 'Ident Right' }) -- indent right and reselect

-- better `J` behaviour
vim.keymap.set('n', 'J', 'mzJ`z', { desc = '[J]oin Line Below' }) -- join line below cursor to the current line maintaining cursor position

-- clipboard
vim.keymap.set(
    { 'n', 'v' },
    '<leader>y',
    '"+y',
    { desc = '[Y]ank Selection to Clipboard' }
) -- yank selection to clipboard
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = '[Y]ank Line to Clipboard' }) -- yank line to clipboard
vim.keymap.set(
    { 'n', 'v' },
    '<leader>p',
    '"+p',
    { desc = '[P]aste from Clipboard' }
) -- paste from clipboard

-- window management
vim.keymap.set('n', '<C-h', '<C-W>h', { desc = 'Move to Window Left' })
vim.keymap.set('n', '<C-j', '<C-W>j', { desc = 'Move to Window Down' })
vim.keymap.set('n', '<C-k', '<C-W>k', { desc = 'Move to Window Up' })
vim.keymap.set('n', '<C-l', '<C-W>l', { desc = 'Move to Window Right' })
vim.keymap.set(
    'n',
    '<leader>-',
    '<cmd>split<CR>',
    { desc = 'Create Horizontal Split' }
)
vim.keymap.set(
    'n',
    '<leader>\\',
    '<cmd>vsplit<CR>',
    { desc = 'Create Vertical Split' }
)
vim.keymap.set('n', '<leader>x', '<C-W>q', { desc = 'Close Current Window' })
