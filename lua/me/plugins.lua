vim.pack.add({
    -- global dependencies
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/echasnovski/mini.icons',
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
    'https://github.com/folke/snacks.nvim',
}, { confirm = false })

local post_update_or_install_group =
    vim.api.nvim_create_augroup('PackPostUpdateOrInstall', { clear = true })
vim.api.nvim_create_autocmd('User', {
    group = post_update_or_install_group,
    pattern = 'PackChanged',
    callback = function(args)
        local data = args.data or {}
        local spec = data.spec or {}
        local name = spec.name or ''
        local src = spec.src or ''

    end,
})

vim.api.nvim_create_user_command('UpdatePlugins', function()
    vim.pack.update()
end, {})

require('nvim-web-devicons').setup({})
require('mini.icons').setup({})

require('catppuccin').setup(require('me.config.colourscheme'))
vim.cmd('colorscheme catppuccin')

require('snacks').setup(require('me.config.snacks'))
vim.keymap.set('n', '<leader>sf', function()
    require('snacks').picker.files()
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', function()
    require('snacks').picker.grep()
end, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sh', function()
    require('snacks').picker.help()
end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function()
    require('snacks').picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })

