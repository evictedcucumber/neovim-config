---@class me.LspServerSetup
local M = {}

M.server_name = 'lua_ls'

M.settings = {
    Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false },
        codeLens = { enable = true },
        completion = { callSnippet = 'Replace' },
        doc = { privateName = { '^_' } },
        hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = 'Disable',
            semicolon = 'Disable',
            arrayIndex = 'Disable',
        },
        telemetry = { enable = false },
    },
}

return M
