vim.g.custom_augroup = function(name)
    return vim.api.nvim_create_augroup('Me' .. name, { clear = true })
end

vim.g.setup_lsp = function(name, settings)
    vim.lsp.config(name, settings)
    vim.lsp.enable(name)
end

require('me.options')
require('me.keymaps')
require('me.lazy')
require('me.highlights')
