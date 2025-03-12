local starter = require('mini.starter')

starter.setup({
    ---@diagnostic disable-next-line: keyword
    header = '███    ██ ███████  ██████  ██    ██ ██ ███    ███\n████   ██ ██      ██    ██ ██    \
    ██ ██ ████  ████\n██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██\n██  ██ ██ ██      ██    █\
    █  ██  ██  ██ ██  ██  ██\n██   ████ ███████  ██████    ████   ██ ██      ██\n',
    footer = '',
    items = {
        {
            action = function()
                local path = vim.fn.stdpath('config')
                vim.cmd('Telescope find_files cwd=' .. path)
            end,
            name = 'Search in Neovim Config',
            section = 'Telescope',
        },
        starter.sections.telescope(),
        starter.sections.recent_files(9, true, false),
        {
            action = function()
                local path = vim.fn.stdpath('config')
                vim.cmd('cd' .. path)
                print('Switched to Neovim Config directory.')
            end,
            name = 'Switch to Neovim Config',
            section = 'Builtin actions',
        },
        starter.sections.builtin_actions(),
    },
    content_hooks = {
        starter.gen_hook.aligning('center', 'center'),
        starter.gen_hook.indexing('all', { 'Telescope', 'Builtin actions' }),
    },
})
