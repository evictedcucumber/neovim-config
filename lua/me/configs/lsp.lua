vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    },
    virtual_text = true,
})

local on_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set
    map('n', 'gd', function()
        Snacks.picker.lsp_definitions()
    end, opts('Go to definition'))
    map('n', 'gD', function()
        Snacks.picker.lsp_declarations()
    end, opts('Go to declaration'))
    map('n', 'gi', function()
        Snacks.picker.lsp_implementations()
    end, opts('Go to implementation'))
    map('n', 'gr', function()
        Snacks.picker.lsp_references()
    end, opts('Go to references'))
    map('n', '<leader>rn', vim.lsp.buf.rename, opts('Rename'))
    map(
        { 'n', 'v' },
        '<leader>ca',
        vim.lsp.buf.code_action,
        opts('Code Actions')
    )
    map('n', 'K', vim.lsp.buf.hover, opts('Show Hover Documentation'))
    map('n', '<C-f>', function() end, opts('Scroll Down Hover Documentation'))
    map('n', '<C-b>', function() end, opts('Scroll Up Hover Documentation'))
end

local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)

vim.lsp.config('*', { capabilities = capabilities, on_attach = on_attach })

local lsp_setup = function(language)
    require('me.configs.languages.' .. language).lsp()
end

lsp_setup('nix')
lsp_setup('lua')

-- lspconfig.clangd.setup({
--     capabilities = vim.tbl_deep_extend('force', capabilities, {
--         offsetEncoding = { 'utf-16' },
--     }),
--     cmd = {
--         'clangd',
--         '--background-index',
--         '--clang-tidy',
--         '--header-insertion=iwyu',
--         '--completion-style=detailed',
--         '--function-arg-placeholders',
--         '--fallback-style=llvm',
--     },
--     init_options = {
--         usePlaceholders = true,
--         completeUnimported = true,
--         clangdFileStatus = true,
--     },
--     filetypes = { 'cpp' },
-- })
--
-- lspconfig.cmake.setup({ capabilities = capabilities, filetypes = { 'cmake' } })
--
-- lspconfig.bashls.setup({ capabilities = capabilities, filetypes = { 'bash' } })
--
-- lspconfig.rust_analyzer.setup({
--     capabilities = capabilities,
--     filetypes = { 'rust' },
--     settings = {
--         ['rust-analyzer'] = {
--             cargo = { allFeatures = true },
--         },
--     },
-- })
