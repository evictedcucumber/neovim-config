local M = { 'folke/noice.nvim' }
M.dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' }

M.event = 'VeryLazy'

M.opts = {
    cmdline = { view = 'cmdline' },
    routes = {
        {
            filter = {
                event = 'notify',
                find = 'No information available',
            },
            opts = { skip = true },
        },
    },
    lsp = {
        hover = { enabled = true },
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
        },
    },
    signature = { enabled = false },
    messages = {
        enabled = true,
        view = 'mini',
        view_error = 'mini',
        view_warn = 'mini',
    },
    presets = { lsp_doc_border = true },
}

return M
