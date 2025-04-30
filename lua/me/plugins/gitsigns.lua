local M = { 'lewis6991/gitsigns.nvim' }

M.event = { 'BufReadPre', 'BufNewFile' }

M.opts = {
    signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
}

return M
