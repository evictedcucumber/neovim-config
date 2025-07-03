return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    init = function()
        require('nvim-treesitter').install({
            'vim',
            'regex',
            'lua',
            'bash',
            'markdown',
            'markdown-inline',
            'c',
            'cpp',
            'python',
            'cmake',
            'doxygen',
            'editorconfig',
            'rust',
            'toml',
            'yaml',
            'make',
        })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '<filetype>' },
            callback = function()
                vim.treesitter.start()
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
