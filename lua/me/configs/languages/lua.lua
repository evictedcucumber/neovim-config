---@class me.LspServer
local M = {}

M.lsp = function(capabilities, on_attach)
    Me.setup_lsp('lua_ls', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
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
        },
    })
end

M.formatter = function(formatters_by_ft)
    formatters_by_ft.lua = { 'stylua' }
end

M.linter = function(linters_by_ft)
    linters_by_ft.lua = { 'luacheck' }
end

return M
