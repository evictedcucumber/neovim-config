return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            theme = 'catppuccin',
            disabled_filetypes = {
                statusline = {
                    'dapui_scopes',
                    'dapui_breakpoints',
                    'dapui_stacks',
                    'dapui_watches',
                    'dap-repl',
                    'dapui_console',
                },
            },
        },
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
