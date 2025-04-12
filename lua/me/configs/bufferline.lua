local highlights = require('catppuccin.groups.integrations.bufferline').get()

require('bufferline').setup({
    options = {
        themable = true,
        numbers = 'none',
        diagnostics = 'nvim_lsp',
        show_close_icon = false,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
        hover = {
            enabled = false,
        },
        max_name_length = 15,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 15,
        sort_by = 'insert_at_end',
        highlights = highlights,
    },
})
