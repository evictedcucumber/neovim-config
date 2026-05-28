if
    not _G.pack_wrapper.add(
        'nvim-treesitter',
        'nvim-treesitter',
        { version = 'main' }
    )
then
    return
end
if
    not _G.pack_wrapper.add(
        'nvim-treesitter',
        'nvim-treesitter-context',
        { name = 'treesitter-context' }
    )
then
    return
end

local ts_languages = {
    'bash',
    'comment',
    'editorconfig',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'html',
    'latex',
    'lua',
    'make',
    'markdown',
    'nix',
    'python',
    'regex',
    'rust',
    'toml',
    'vim',
    'yaml',
    'hyprlang',
}
require('nvim-treesitter').install(ts_languages)
require('treesitter-context').setup({ max_lines = 3 })
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('Treesitter', { clear = true }),
    pattern = ts_languages,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
    end,
})
