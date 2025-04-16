local M = {}

M.lsp = function()
    vim.g.setup_lsp('lua_ls', {
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

M.formatter = function(conform)
    conform.formatters_by_ft.lua = { 'stylua' }
end

M.linter = function(lint)
    lint.linters_by_ft.lua = { 'luacheck' }
end

return M
