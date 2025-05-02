local M = { 'echasnovski/mini.nvim' }
M.version = false

M.event = { 'BufNewFile', 'BufReadPre' }

M.config = function()
    local mini_setup = function(name, opts)
        require('mini.' .. name).setup(opts or {})
    end

    mini_setup('ai')
    mini_setup('comment')
    mini_setup('move')
    mini_setup('surround')
    mini_setup('cursorword')
    mini_setup('icons')
end

return M
