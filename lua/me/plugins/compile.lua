return {
    'ej-shafran/compile-mode.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Compile',
    keys = {
        {
            '<leader>cc',
            '<CMD>Compile<CR>',
            desc = 'Edit [C]ompile [C]ommand',
        },
        {
            '<leader>cC',
            '<CMD>Compile<CR><CR>',
            desc = 'Rerun [C]ompile [C]ommand',
        },
    },
    config = function()
        vim.g.compile_mode = {}
    end,
}
