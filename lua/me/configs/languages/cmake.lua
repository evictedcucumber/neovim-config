---@class me.LspServer
local M = {}

M.lsp = function(capabilities, on_attach)
    Me.setup_lsp('cmake', {
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return M
