local M = {}

---@param capabilities lsp.ClientCapabilities
---@param on_attach fun(client: vim.lsp.Client, bufnr: integer)
M.setup = function(capabilities, on_attach)
    ---@param server string
    ---@param settings? vim.lsp.Config
    local lsp_setup = function(server, settings)
        settings = settings or {}
        settings.capabilities = settings.capabilities or capabilities
        settings.on_attach = settings.on_attach or on_attach

        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
    end

    -- lua-language-server
    lsp_setup('lua_ls', {
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
    -- /lua-language-server
    -- clangd
    lsp_setup('clangd', {
        capabilities = vim.tbl_deep_extend(
            'force',
            capabilities,
            { offsetEncoding = { 'utf-16' } }
        ),
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
    -- /clangd

    -- cmake-language-server
    lsp_setup('cmake')
    -- /cmake-language-server
    -- nixd
    lsp_setup('nixd', {
        settings = {
            nixd = { formatting = { command = { 'alejandra' } } },
        },
    })
    -- /nixd
    -- rust-analyzer
    lsp_setup('rust_analyzer')
    -- /rust-analyzer
    -- pyright
    lsp_setup('pyright')
    -- /pyright
    -- autotools_ls
    lsp_setup('autotools_ls')
    -- /autotools_ls
end

return M
