return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        auto_install = true,
        sync_install = true,
        ensure_installed = {
            -- required
            'vim',
            'regex',
            'lua',
            'bash',
            'markdown',
            'markdown_inline',
        },
        highlight = { enable = true },
        indent = { enable = true },
    },
}
