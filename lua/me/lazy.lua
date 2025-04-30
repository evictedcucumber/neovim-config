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
            'L3MON4D3/LuaSnip',
            build = 'make install_jsregexp',
            dependencies = { 'rafamadriz/friendly-snippets' },
        },
        {
            'folke/lazydev.nvim',
            dependencies = 'neovim/nvim-lspconfig',
            ft = 'lua',
            opts = { library = { 'folke/snacks.nvim' } },
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
        enabled = true,
        notify = false,
    },
})
