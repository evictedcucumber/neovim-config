return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
        },
        format_on_save = {
            timeout_ms = 3000,
            lsp_format = 'fallback',
        },
    },
}
