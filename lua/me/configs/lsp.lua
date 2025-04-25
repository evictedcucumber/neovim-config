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

Me.setup_lsp('harper_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ['harper-ls'] = {
            userDictPath = vim.fn.stdpath('cache')
                .. '/harper-ls/dictionary.txt',
            dialetc = 'British',
            codeActions = { ForceStable = true },
            linters = {
                LinkingVerbs = true,
                BoringWords = true,
                UseGenitive = true,
                SpelledNumbers = true,
            },
            markdown = { IgnoreLinkTitle = true },
        },
    },
})

local lsp = function(language)
    require('me.configs.languages.' .. language).lsp(capabilities, on_attach)
end

lsp('nix')
lsp('lua')
lsp('rust')
lsp('c-cpp')
lsp('cmake')
