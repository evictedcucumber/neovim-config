return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'nvim-treesitter.configs',
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
