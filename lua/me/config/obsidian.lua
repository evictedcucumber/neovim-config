return {
    -- TODO: Remove when plugin goes to 4.0
    legacy_commands = false,
    workspaces = {
        {
            name = 'myvault',
            path = '~/myvault',
        },
    },
    completion = { nvim_cmp = false, blink = true },
    new_notes_dir = 'current_dir',
    picker = { name = 'snacks.pick' },
    ui = { enable = false },
}
