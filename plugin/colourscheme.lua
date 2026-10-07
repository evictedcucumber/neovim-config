local pack = require('pack')

if not pack.add('dracula', 'vim', { name = 'dracula', requireable = false }) then
    return
end

vim.g.dracula_bold = 1
vim.g.dracula_italic = 1
vim.g.dracula_colorterm = 1

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('me_dracula', { clear = true }),
    pattern = 'dracula',
    callback = function()
        local c = {}
        for k, v in pairs(vim.g['dracula#palette']) do
            c[k] = type(v) == 'table' and v[1] or v
        end
        local highlights = {
            SnacksPickerBorder = { fg = c.comment },
            SnacksPickerTitle = { fg = c.cyan, bold = true },
            SnacksPickerMatch = { fg = c.pink, bold = true },
            SnacksPickerPrompt = { fg = c.purple },
            SnacksPickerDir = { fg = c.comment },
            SnacksPickerListCursorLine = { bg = c.selection },
            SnacksIndent = { fg = c.subtle },
            SnacksIndentScope = { fg = c.comment },
        }
        for group, hl in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, hl)
        end
    end,
})

vim.cmd('colorscheme dracula')
