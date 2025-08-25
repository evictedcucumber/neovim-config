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

add_plugin('nvim-tree/nvim-web-devicons')
safe_setup('nvim-web-devicons', {})

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

require('nvim-treesitter').install(require('me.config.treesitter'))
require('treesitter-context').setup({ max_lines = 3 })
