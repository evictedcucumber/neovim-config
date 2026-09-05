local pack = require('pack')

if not pack.add('nvim-mini', 'mini.nvim', { requireable = false }) then
    return
end

require('mini.icons').setup({})
require('mini.ai').setup({})
require('mini.align').setup({})
require('mini.move').setup({})
require('mini.surround').setup({})
