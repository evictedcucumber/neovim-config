return {
    {
        'folke/lazydev.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        ft = 'lua',
        opts = {},
    },
    {
        'm4xshen/hardtime.nvim',
        lazy = false,
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {},
    },
    { 'nvim-tree/nvim-web-devicons', lazy = false, opts = {} },
    { 'nvim-lua/plenary.nvim', lazy = false },
    { 'echasnovski/mini.icons', lazy = false, version = false, opts = {} },
}
