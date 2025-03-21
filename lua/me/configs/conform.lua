local conform = require('conform')

conform.setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format' },
        cmake = { 'cmake_format' },
        bash = { 'shfmt' },
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader>fm', function()
    conform.format({ timeout_ms = 3000, lsp_format = 'fallback' }, function(err)
        if not err then
            vim.notify('Successfully formatted.')
            vim.cmd('write')
        end
    end)
end, { desc = 'Format Buffer' })

vim.o.formatexpr = "v:lua.require'conform'.formatexpr"
