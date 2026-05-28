vim.pack.add({ { src = 'https://github.com/nvim-lua/plenary.nvim' } })

local got_log, plog = pcall(require, 'plenary.log')
if not got_log then
    vim.notify('Unable to require "plenary.log".', vim.log.levels.ERROR)
    return
end

return plog.new({ plugin = 'pack-wrapper' })
