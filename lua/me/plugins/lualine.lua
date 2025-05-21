return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = { theme = 'catppuccin' },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'filename' },
            lualine_x = {},
            lualine_y = { 'filetype' },
            lualine_z = { 'location' },
        },
    },
}
