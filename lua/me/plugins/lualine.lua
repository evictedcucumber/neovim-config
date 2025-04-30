local M = { 'nvim-lualine/lualine.nvim' }
M.dependencies = { 'folke/noice.nvim' }

M.event = 'VeryLazy'

M.opts = {
    options = { theme = 'catppuccin' },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
            {
                ---@diagnostic disable-next-line:undefined-field
                require('noice').api.status.mode.get,
                ---@diagnostic disable-next-line:undefined-field
                cond = require('noice').api.status.mode.has,
            },
            'lsp_status',
        },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
    },
}

return M
