local pack = require('pack')

if not pack.add('folke', 'which-key.nvim') then
    return
end

require('which-key').setup({
    preset = 'helix',
    win = { wo = { winblend = 0 } },
    icons = { mappings = true, icons = {} },
})
