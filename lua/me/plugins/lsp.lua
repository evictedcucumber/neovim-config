return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'folke/snacks.nvim', 'saghen/blink.cmp', { 'j-hui/fidget.nvim', opts = {} } },
    init = function()
        vim.keymap.del('n', 'gra')
        vim.keymap.del('n', 'grr')
        vim.keymap.del('n', 'gri')
        vim.keymap.del('n', 'grn')

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
    end,
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)

        local on_attach = function(_, bufnr)
            local function opts(desc)
                return { noremap = true, buffer = bufnr, desc = desc }
            end

            vim.keymap.set('n', 'gd', function()
                require('snacks').picker.lsp_definitions()
            end, opts('[G]o to LSP [D]efinition'))
            vim.keymap.set('n', 'gt', function()
                require('snacks').picker.lsp_type_definitions()
            end, opts('[G]o to LSP [T]ype Definition'))
            vim.keymap.set('n', 'gD', function()
                require('snacks').picker.lsp_declarations()
            end, opts('[G]o to LSP [D]eclaration'))
            vim.keymap.set('n', 'gi', function()
                require('snacks').picker.lsp_implementations()
            end, opts('[G]o to [I]mplementation'))
            vim.keymap.set('n', 'gr', function()
                require('snacks').picker.lsp_references()
            end, opts('[G]o to [R]eferences'))
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('LSP [R]e[n]ame'))
            vim.keymap.set(
                { 'n', 'v' },
                '<leader>ca',
                vim.lsp.buf.code_action,
                opts('Show LSP [C]ode [A]ctions')
            )
            vim.keymap.set('n', 'K', function()
                vim.lsp.buf.hover({
                    border = 'rounded',
                })
            end, opts('Show LSP Hover Documentation'))
        end

        local lsp_setup = function(server, settings)
            vim.lsp.config(server, settings)
            vim.lsp.enable(server)
        end

        -- lua-language-server
        lsp_setup('lua_ls', {
            capabilities = capabilities,
            on_attach = on_attach,
            on_init = function()
                vim.opt.colorcolumn = '99'
            end,
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
            on_attach = on_attach,
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
        lsp_setup('cmake', {})
        -- /cmake-language-server
        -- harper-ls
        lsp_setup('harper_ls', {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ['harper-ls'] = {
                    userDictPath = vim.fn.stdpath('cache') .. '/harper-ls/dictionary.txt',
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
        -- /harper-ls
        -- nixd
        lsp_setup('nixd', {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                nixd = { formatting = { command = { 'alejandra' } } },
            },
        })
        -- /nixd
        -- rust-analyzer
        lsp_setup('rust-analyzer', {
            capabilities = capabilities,
            on_attach = on_attach,
            on_init = function()
                vim.opt.colorcolumn = '99'
                vim.opt.tabstop = 4
                vim.opt.softtabstop = 4
                vim.opt.shiftwidth = 4
            end,
            settings = {
                ['rust-analyzer'] = {
                    cargo = { allFeatures = true },
                },
            },
        })
        -- /rust-analyzer
    end,
}
