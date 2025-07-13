return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        'folke/snacks.nvim',
        'saghen/blink.cmp',
        {
            'j-hui/fidget.nvim',
            opts = { notification = { window = { winblend = 0 } } },
        },
    },
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
        require('me.lsp').setup()
    end,
}
