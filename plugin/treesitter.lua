local pack = require('pack')

if not pack.add('nvim-treesitter', 'nvim-treesitter', { version = 'main' }) then
    return
end
if
    not pack.add(
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
    'css',
    'editorconfig',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'html',
    'hyprlang',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    'markdown',
    'nix',
    'powershell',
    'python',
    'regex',
    'rust',
    'scss',
    'svelte',
    'toml',
    'tsx',
    'typst',
    'vim',
    'vue',
    'yaml',
}
require('nvim-treesitter').install(ts_languages)
require('treesitter-context').setup({ max_lines = 3 })
local ts_filetypes =
    vim.list_extend(vim.deepcopy(ts_languages), { 'yaml.ansible' })

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('Treesitter', { clear = true }),
    pattern = ts_filetypes,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
    end,
})
