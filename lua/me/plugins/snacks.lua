local M = { 'folke/snacks.nvim' }

M.priority = 1000
M.lazy = false
M.keys = {
    {
        '<leader>sf',
        function()
            Snacks.picker.files()
        end,
        desc = 'Search Files',
    },
    {
        '<leader>sg',
        function()
            Snacks.picker.grep()
        end,
        desc = 'Search with Grep',
    },
    {
        '<leader>sb',
        function()
            Snacks.picker.buffers({ current = false, sort_lastused = true })
        end,
        desc = 'Search Buffers',
    },
    {
        '<leader>ss',
        function()
            Snacks.picker.spelling()
        end,
        desc = 'Spell Suggest',
    },
}

local exclude = {
    '**/*.lock',
    '**/build/',
    '**/.cache/',
    '**/target/',
}

M.opts = {
    dashboard = {
        preset = {
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
                { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
                { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
            },
        },
        sections = {
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
        },
    },
    picker = {
        layout = { preset = 'ivy' },
        matcher = {
            cwd_bonus = true,
            frecency = true,
        },
        sources = {
            grep = {
                hidden = true,
                exclude = exclude,
            },
            files = {
                hidden = true,
                exclude = exclude,
            },
        },
    },
    indent = { animate = { enabled = false } },
    quickfile = { enabled = true },
    input = { enabled = true },
}

return M
