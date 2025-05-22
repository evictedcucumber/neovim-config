return {
    'mikavilpas/yazi.nvim',
    dependencies = 'folke/snacks.nvim',
    lazy = false,
    keys = {
        { '_', '<CMD>Yazi cwd<CR>', desc = 'Open Yazi in CWD' },
        { '-', '<CMD>Yazi<CR>', desc = 'Open Yazi at current file' },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
    opts = { open_for_directories = true },
}
