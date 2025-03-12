local showmode = require('noice').api.status.mode

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'rose-pine',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
            ---@diagnostic disable-next-line:undefined-field
            { showmode.get, cond = showmode.has },
        },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
    },
})
