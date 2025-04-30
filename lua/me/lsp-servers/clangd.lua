---@class me.LspServerSetup
local M = {}

M.server_name = 'clangd'

M.capabilities = { offsetEncoding = { 'utf-16' } }

M.cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
}

M.init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
}

return M
