if not _G.pack_wrapper.add('nvim-lualine', 'lualine.nvim') then
    return
end

require('lualine').setup({
    options = { theme = 'rose-pine' },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
    },
})
