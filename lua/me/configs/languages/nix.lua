local M = {}

M.lsp = function()
    vim.g.setup_lsp('nixd', {
        settings = {
            nixd = { formatting = { command = { 'alejandra' } } },
        },
    })
end

return M
