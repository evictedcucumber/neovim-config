vim.pack.add({
    -- global dependencies
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/echasnovski/mini.icons',
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
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

