---@module 'render-markdown'
---@type render.md.UserConfig
return {
    preset = 'obsidian',
    completions = {
        lsp = {
            enabled = true,
        },
    },
    render_modes = { 'n', 'c', 't' },
}
