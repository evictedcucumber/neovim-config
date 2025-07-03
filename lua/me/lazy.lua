local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'me.plugins' },
        { import = 'me.plugins.language-specific' },
        {
            dir = '~/repos/easycmd.nvim',
            cmd = { 'EasyCmdRun', 'EasyCmdEdit' },
            keys = {
                { '<leader>cc', '<cmd>EasyCmdRun 1<CR>', desc = 'Run [C]omplie [C]ommand' },
                { '<leader>cC', '<cmd>EasyCmdEdit 1<CR>', desc = 'Edit [C]omplie [C]ommand' },
                { '<leader>cr', '<cmd>EasyCmdRun 2 vsplit<CR>', desc = 'Run [C]ommand [R]un' },
                { '<leader>cR', '<cmd>EasyCmdEdit 2<CR>', desc = 'Edit [C]ommand [R]un' },
                { '<leader>ct', '<cmd>EasyCmdRun 3<CR>', desc = 'Run [C]ommand [T]est' },
                { '<leader>cT', '<cmd>EasyCmdEdit 3<CR>', desc = 'Edit [C]ommand [T]est' },
            },
            ---@type easycmd.Config
            opts = {},
        },
    },
    install = {
        missing = true,
        colorscheme = { 'catppuccin' },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
})
