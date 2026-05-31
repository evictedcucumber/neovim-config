if not _G.pack_wrapper.add('rose-pine', 'neovim', { name = 'rose-pine' }) then
    return
end

require('rose-pine').setup({
    variant = 'main',
    dark_variant = 'main',
    enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
    },
    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },
    highlight_groups = {
        SnacksPickerBorder = { fg = 'muted' },
        SnacksPickerTitle = { fg = 'foam', bold = true },
        SnacksPickerMatch = { fg = 'rose', bold = true },
        SnacksPickerPrompt = { fg = 'iris' },
        SnacksPickerDir = { fg = 'muted' },
        SnacksPickerListCursorLine = { bg = 'highlight_low' },
        SnacksIndent = { fg = 'muted', blend = 30 },
        SnacksIndentScope = { fg = 'subtle' },
    },
})
vim.cmd('colorscheme rose-pine')
