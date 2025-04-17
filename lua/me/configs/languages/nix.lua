---@class Me.LspServer
local M = {}

M.lsp = function(capabilities, on_attach)
    Me.setup_lsp('nixd', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            nixd = { formatting = { command = { 'alejandra' } } },
        },
    })
end

return M
