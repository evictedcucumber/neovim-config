---@class me.LspServer
local M = {}

M.lsp = function(capabilities, on_attach)
    Me.setup_lsp('clangd', {
        on_attach = on_attach,
        capabilities = vim.tbl_deep_extend('force', capabilities, {
            offsetEncoding = { 'utf-16' },
        }),
        cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
    })
end

return M
