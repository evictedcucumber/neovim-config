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
        local lsp_augroup = vim.api.nvim_create_augroup('lsp_augroup',
            { clear = true })
        local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)

        ---@param client vim.lsp.Client
        ---@param bufnr integer
        local on_attach = function(client, bufnr)
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
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
                opts('LSP [R]e[n]ame'))
            vim.keymap.set(
                { 'n', 'v' },
                '<leader>ca',
                vim.lsp.buf.code_action,
                opts('Show LSP [C]ode [A]ctions')
            )
            vim.keymap.set('n', 'K', function()
                vim.lsp.buf.hover({
                    focusable = true,
                    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
                    border = 'rounded',
                })
            end, opts('Show LSP Hover Documentation'))
            vim.keymap.set('n', '<leader>d', function()
                vim.diagnostic.open_float(nil, {
                    focusable = false,
                    scope = 'cursor',
                    border = 'rounded',
                    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
                })
            end, opts('Show [D]iagnostic in Float'))
            vim.keymap.set('n', '<leader>D', function()
                vim.diagnostic.setloclist()
            end, opts('Show all [D]iagnostics'))

            vim.api.nvim_create_autocmd('InsertEnter', {
                buffer = bufnr,
                group = lsp_augroup,
                callback = function()
                    vim.diagnostic.enable(false, { bufnr = bufnr })
                end,
            })
            vim.api.nvim_create_autocmd('InsertLeave', {
                buffer = bufnr,
                group = lsp_augroup,
                callback = function()
                    vim.diagnostic.enable(true, { bufnr = bufnr })
                end,
            })

            if client:supports_method('textDocument/formatting', bufnr) then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = vim.api.nvim_create_augroup('LSP_FORMAT',
                        { clear = true }),
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                    end,
                })

                vim.keymap.set('n', '<leader>fm', function()
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                end, opts('[F]or[m]at Buffer'))
            end
        end

        require('me.lsp-servers').setup(capabilities, on_attach)
    end,
}
