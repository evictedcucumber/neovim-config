local M = { 'mikavilpas/yazi.nvim' }
M.dependencies = 'folke/snacks.nvim'

M.event = 'VeryLazy'
M.keys = {
    { '_', '<CMD>Yazi cwd<CR>', desc = 'Open Yazi in CWD' },
    { '-', '<CMD>Yazi<CR>', desc = 'Open Yazi at current file' },
}

M.init = function()
    vim.g.loaded_netrwPlugin = 1
end

M.opts = { open_for_directories = true }

return M
