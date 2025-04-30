local M = { 'stevearc/conform.nvim' }

M.event = 'BufWritePre'
M.cmd = 'ConformInfo'

M.init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

M.opts = {
    formatters_by_ft = {
        lua = { 'stylua' },
    },
    format_on_save = {
        timeout_ms = 3000,
        lsp_format = 'fallback',
    },
}

return M
