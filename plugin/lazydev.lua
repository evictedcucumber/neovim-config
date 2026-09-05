local pack = require('pack')

if not pack.add('folke', 'lazydev.nvim') then
    return
end

require('lazydev').setup({})
