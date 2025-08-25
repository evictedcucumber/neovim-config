local add_plugin = require('me.util').add_plugin
local add_plugins = require('me.util').add_plugins
local safe_setup = require('me.util').safe_setup
local add_post_pack_install_update_hook =
    require('me.util').add_post_pack_install_update_hook

local post_update_or_install_group =
    vim.api.nvim_create_augroup('PackPostUpdateOrInstall', { clear = true })
vim.api.nvim_create_autocmd('PackChanged', {
    group = post_update_or_install_group,
    callback = function(args)
        local data = args.data or {}
        local kind = data.kind or ''
        local spec = data.spec or {}
        local name = spec.name or ''
        local path = data.path

        if kind == 'install' or kind == 'update' then
            for _, entry in
                ipairs(require('me.util').post_pack_install_update_hooks)
            do
                local hooked_name, hook = entry.name, entry.hook
                if hooked_name == name then
                    vim.cmd('packadd ' .. hooked_name)
                    local ok, _ = pcall(hook, path)
                    if not ok then
                        vim.print(
                            'Unable to call hook function for `'
                                .. hooked_name
                                .. '`.'
                        )
                    end
                end
            end
        end
    end,
})

add_plugins({ { src = 'nvim-lua/plenary.nvim' } })


add_plugin('echasnovski/mini.icons')
safe_setup('mini.icons', {})

add_plugin('catppuccin/nvim', 'catppuccin')
safe_setup('catppuccin', require('me.config.colourscheme'))
vim.cmd('colorscheme catppuccin')

add_plugin('folke/snacks.nvim')
safe_setup('snacks', require('me.config.snacks'))
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

add_post_pack_install_update_hook('nvim-treesitter', function()
    vim.schedule(function()
        vim.notify('Starting nvim-treesitter update', vim.log.levels.INFO)
        require('nvim-treesitter').update():wait()
        vim.notify('Finished nvim-treesitter update', vim.log.levels.INFO)
    end)
end)
add_plugins({
    { src = 'nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'nvim-treesitter/nvim-treesitter-context' },
})
local ts_require_ok, ts_require_value = pcall(require, 'nvim-treesitter')
if ts_require_ok then
    local ts_install_ok, ts_install_err =
        pcall(ts_require_value.install, require('me.config.treesitter'))
    if not ts_install_ok then
        vim.print(ts_install_err)
    end
else
    vim.print(ts_require_value)
end
safe_setup('treesitter-context', { max_lines = 3 })

add_plugin('folke/which-key.nvim')
safe_setup('which-key', { preset = 'helix', win = { wo = { winblend = 0 } } })

add_post_pack_install_update_hook('blink.cmp', function(path)
    vim.schedule(function()
        vim.notify('Starting blink.cmp build', vim.log.levels.INFO)
        vim.system(
            { 'nix', 'run', '--accept-flake-config', '.#build-plugin' },
            { cwd = path }
        ):wait()
        vim.notify('Finished blink.cmp build', vim.log.levels.INFO)
    end)
end)

add_plugin('evictedcucumber/lazydev.nvim')
safe_setup('lazydev', {})

add_plugin('Saghen/blink.cmp')
safe_setup('blink.cmp', require('me.config.blink'))
vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
})

add_plugin('j-hui/fidget.nvim')
safe_setup('fidget', { notification = { window = { winblend = 0 } } })

