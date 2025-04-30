local M = { 'catppuccin/nvim' }
M.name = 'catppuccin'

M.priority = 1000

M.init = function()
    vim.cmd('colorscheme catppuccin')
end

M.opts = {
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
    },
    custom_highlights = function(colors)
        return {
            NormalFloat = { fg = colors.text, bg = colors.none },
            Pmenu = { link = 'NormalFloat' },
            FloatBorder = { link = 'NormalFloat' },
        }
    end,
}

return M
