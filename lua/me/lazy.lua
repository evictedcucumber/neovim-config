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
        {
            dir = '~/repos/easycmd.nvim',
            cmd = 'EasyCmd',
            keys = {
                { '<leader>cc', '<cmd>EasyCmd run 1<CR>', desc = 'Run [C]omplie [C]ommand' },
                { '<leader>cC', '<cmd>EasyCmd edit 1<CR>', desc = 'Edit [C]omplie [C]ommand' },
                { '<leader>cr', '<cmd>EasyCmd run 2 vsplit<CR>', desc = 'Run [C]ommand [R]un' },
                { '<leader>cR', '<cmd>EasyCmd edit 2<CR>', desc = 'Edit [C]ommand [R]un' },
                { '<leader>ct', '<cmd>EasyCmd run 3<CR>', desc = 'Run [C]ommand [T]est' },
                { '<leader>cT', '<cmd>EasyCmd edit 3<CR>', desc = 'Edit [C]ommand [T]est' },
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
