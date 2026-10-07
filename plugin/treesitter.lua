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

require('nvim-treesitter').install({
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
    'typescript',
    'typst',
    'vim',
    'vue',
    'yaml',
})
require('treesitter-context').setup({ max_lines = 3 })

-- start treesitter for any filetype with an installed parser; parser names
-- don't always match filetypes (e.g. tsx -> typescriptreact, powershell -> ps1)
-- so let vim.treesitter resolve the language rather than listing filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('Treesitter', { clear = true }),
    callback = function(ev)
        if not pcall(vim.treesitter.start, ev.buf) then
            return
        end
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo[ev.buf].indentexpr =
            'v:lua.require"nvim-treesitter".indentexpr()'
    end,
})
