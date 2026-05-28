_G.keymap = vim.keymap.set

-- center search results
_G.keymap('n', 'n', 'nzzzv', { desc = '[N]ext Search Result' }) -- center screen to next search result
_G.keymap('n', 'N', 'Nzzzv', { desc = 'Previous Search Result' }) -- center screen to previous search result

-- center half-page scroll
_G.keymap('n', '<C-d>', '<C-d>zz', { desc = 'Scroll [D]own Half-Page' }) -- scroll down half-page centered
_G.keymap('n', '<C-u>', '<C-u>zz', { desc = 'Scroll [U]p Half-Page' }) -- scroll up half-page centered

-- better visual mode indenting
_G.keymap('v', '<', '<gv', { desc = 'Ident Left' }) -- indent left and reselect
_G.keymap('v', '>', '>gv', { desc = 'Ident Right' }) -- indent right and reselect

-- better `J` behaviour
_G.keymap('n', 'J', 'mzJ`z', { desc = '[J]oin Line Below' }) -- join line below cursor to the current line maintaining cursor position

-- clipboard
_G.keymap(
    { 'n', 'v' },
    '<leader>y',
    '"+y',
    { desc = '[Y]ank Selection to Clipboard' }
) -- yank selection to clipboard
_G.keymap('n', '<leader>Y', '"+Y', { desc = '[Y]ank Line to Clipboard' }) -- yank line to clipboard
_G.keymap({ 'n', 'v' }, '<leader>p', '"+p', { desc = '[P]aste from Clipboard' }) -- paste from clipboard
