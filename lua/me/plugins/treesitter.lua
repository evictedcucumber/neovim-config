local M = { 'nvim-treesitter/nvim-treesitter' }
M.build = ':TSUpdate'

M.event = { 'BufReadPre', 'BufNewFile' }

M.main = 'nvim-treesitter.configs'
M.opts = {
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
}

return M
