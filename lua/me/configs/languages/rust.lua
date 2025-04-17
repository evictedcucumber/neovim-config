---@class Me.LspServer
local M = {}

M.lsp = function(capabilities, on_attach)
    Me.setup_lsp('rust_analyzer', {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = function()
            vim.opt.colorcolumn = '99'
            vim.opt.tabstop = 4
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
        end,
        settings = {
            ['rust-analyzer'] = {
                cargo = { allFeatures = true },
            },
        },
    })
end

return M
