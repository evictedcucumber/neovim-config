local M = { 'neovim/nvim-lspconfig' }
M.dependencies = 'folke/snacks.nvim'

M.event = { 'BufNewFile', 'BufReadPost' }

M.init = function()
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
end

M.config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
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
        map('n', '<C-f>', function()
            require('noice.lsp').scroll(4)
        end, opts('Scroll Down Hover Documentation'))
        map('n', '<C-b>', function()
            require('noice.lsp').scroll(-4)
        end, opts('Scroll Up Hover Documentation'))
    end

    for _, file in
        ipairs(
            vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/me/lsp-servers')
        )
    do
        ---@type me.LspServerSetup
        local server = require('me.lsp-servers.' .. file:gsub('%.lua$', ''))

        local settings = {
            on_attach = on_attach,
            capabilities = vim.tbl_deep_extend(
                'force',
                capabilities,
                server.capabilities or {}
            ),
        }

        if server.on_init then
            settings.on_init = server.on_init
        end

        if server.cmd then
            settings.cmd = server.cmd
        end

        if server.init_options then
            settings.init_options = server.init_options
        end

        if server.settings then
            settings.settings = server.settings
        end

        if server.server_name then
            vim.lsp.config(server.server_name, settings)
            vim.lsp.enable(server.server_name)
        end
    end
end

return M
