vim.api.nvim_create_autocmd('LspAttach', {
    group = _G.custom_augroup('lsp_attach'),
    callback = function(ev)
        local function opts(desc)
            return { buffer = ev.buf, desc = desc }
        end

        local set = vim.keymap.set
        local buf = vim.lsp.buf
        set('n', 'gd', buf.definition, opts('Go to definition'))
        set('n', 'gD', buf.declaration, opts('Go to declaration'))
        set('n', 'gi', buf.implementation, opts('Go to implementation'))
        set('n', 'gr', buf.references, opts('Go to references'))
        set('n', '<leader>rn', buf.rename, opts('Rename'))
        set({ 'n', 'v' }, '<leader>ca', buf.code_action, opts('Code Actions'))
        set('n', 'K', buf.hover, opts('Show Hover Documentation'))
        set('i', '<C-h>', buf.signature_help, opts('Show Signature Help'))

        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if not client then
            return
        end

        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = _G.custom_augroup('document_highlight'),
                buffer = ev.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                group = _G.custom_augroup('clear_references'),
                buffer = ev.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end

        if client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                group = _G.custom_augroup('codelens_refresh'),
                buffer = ev.buf,
                callback = vim.lsp.codelens.refresh,
            })
        end
    end,
})

local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            codeLens = {
                enable = true,
            },
            completion = {
                callSnippet = 'Replace',
            },
            doc = {
                privateName = { '^_' },
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
            },
        },
    },
})

lspconfig.clangd.setup({
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

lspconfig.cmake.setup({ capabilities = capabilities })
