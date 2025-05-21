return {
    'mikavilpas/yazi.nvim',
    dependencies = 'folke/snacks.nvim',
    event = 'VeryLazy',
    keys = {
        { '_', '<C>Yazi cwd<CR>', desc = 'Open Yazi in CWD' },
        { '-', '<C>Yazi<CR>', desc = 'Open Yazi at current file' },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
    opts = { open_for_directories = true },
}
