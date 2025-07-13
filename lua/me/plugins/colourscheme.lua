return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
        vim.cmd('colorscheme catppuccin')
    end,
    opts = {
        flavour = 'mocha',
        background = { dark = 'mocha' },
        show_end_of_buffer = true,
        default_integrations = true,
        integrations = {
            which_key = true,
            gitsigns = true,
            treesitter = true,
            mini = { enabled = true },
            blink_cmp = true,
            harpoon = true,
            noice = true,
            native_lsp = {
                enabled = true,
                inlay_hint = { background = true },
            },
            notify = true,
            snacks = {
                enabled = true,
                indent_scope_color = 'lavender',
            },
            lsp_trouble = true,
            flash = true,
            fidget = false,
            markdown = true,
            neotest = true,
            dap = true,
            dap_ui = true,
        },
        custom_highlights = function(colors)
            return {
                NormalFloat = { fg = colors.text, bg = colors.none },
                Pmenu = { link = 'NormalFloat' },
                FloatBorder = { link = 'NormalFloat' },
            }
        end,
    },
}
