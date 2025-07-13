return {
    {
        'folke/lazydev.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        ft = 'lua',
        opts = {
            library = { 'nvim-dap-ui' },
        },
    },
    { 'nvim-tree/nvim-web-devicons', lazy = false, opts = {} },
    { 'nvim-lua/plenary.nvim', lazy = false },
    { 'echasnovski/mini.icons', lazy = false, version = false, opts = {} },
}
