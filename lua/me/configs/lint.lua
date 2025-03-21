local lint = require('lint')

lint.linters_by_ft = {
    bash = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
    group = _G.custom_augroup('lint'),
    callback = function()
        lint.try_lint()
    end,
})
