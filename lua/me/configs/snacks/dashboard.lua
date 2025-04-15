local M = {}
M.preset = {
    keys = {
        {
            icon = ' ',
            key = 'f',
            desc = 'Find File',
            action = ":lua Snacks.dashboard.pick('files')",
        },
        {
            icon = ' ',
            key = 'r',
            desc = 'Find Recent Files',
            action = ":lua Snacks.dashboard.pick('recent')",
        },
        {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
        },
        {
            icon = ' ',
            key = 'n',
            desc = 'New File',
            action = ':ene | startinsert',
        },
        {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        {
            icon = '󰒲 ',
            key = 'l',
            desc = 'Lazy',
            action = ':Lazy',
        },
        {
            icon = ' ',
            key = 'm',
            desc = 'Mason',
            action = ':Mason',
        },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
}

M.sections = {
    { section = 'header' },
    { section = 'keys', gap = 1, padding = 1 },
    {
        pane = 2,
        icon = ' ',
        title = 'Recent Files',
        section = 'recent_files',
        indent = 2,
        padding = 1,
        cwd = true,
    },
    {
        pane = 2,
        icon = ' ',
        title = 'Projects',
        section = 'projects',
        indent = 2,
        padding = 1,
    },
    {
        pane = 2,
        icon = ' ',
        title = 'Git Status',
        section = 'terminal',
        enabled = function()
            return Snacks.git.get_root() ~= nil
        end,
        cmd = 'git status --short --branch --renames',
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
    },
}

return M
