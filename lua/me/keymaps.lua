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
