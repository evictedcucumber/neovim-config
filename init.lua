_G.custom_augroup = function(name)
    return vim.api.nvim_create_augroup('Me' .. name, { clear = true })
end

require('me.options')
require('me.keymaps')
require('me.lazy')
require('me.highlights')
