if not _G.pack_wrapper.add('MeanderingProgrammer', 'render-markdown.nvim') then
    return
end
if not _G.pack_wrapper.add('obsidian-nvim', 'obsidian.nvim') then
    return
end

require('render-markdown').setup({
    preset = 'obsidian',
    completions = { lsp = { enabled = true } },
    render_modes = { 'n', 'c', 't' },
})

local hostname = vim.fn.hostname()
local vault_path = hostname == 'seamoth' and '~/Documents/My Obsidian Vault'
    or hostname == 'snowfox' and '~/myvault'
    or ''
local vault_stat = vim.uv.fs_stat(vault_path)
if vault_stat and vault_stat.type == 'directory' then
    require('obsidian').setup({
        legacy_commands = false, -- TODO: Remove when plugin goes to 4.0
        workspaces = {
            { name = 'myvault', path = vault_path },
        },
        completion = { nvim_cmp = false, blink = true },
        new_notes_dir = 'current_dir',
        picker = { name = 'snacks.picker' },
        ---@diagnostic disable-next-line:missing-fields
        ui = { enable = false },
    })
end
