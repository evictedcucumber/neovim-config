local add_plugin = require('me.util').add_plugin
local add_plugins = require('me.util').add_plugins
local safe_setup = require('me.util').safe_setup
local plug = require('me.util').plugin
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

plug('nvim-lua/plenary.nvim', 'plenary')

plug('echasnovski/mini.icons', 'mini.icons', {})

plug(
    'catppuccin/nvim',
    'catppuccin',
    require('me.config.colourscheme'),
    function()
        vim.cmd('colorscheme catppuccin')
    end
)

plug('folke/snacks.nvim', 'snacks', require('me.config.snacks'), function()
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
end)

add_post_pack_install_update_hook('nvim-treesitter', function()
    vim.schedule(function()
        vim.notify('Starting nvim-treesitter update', vim.log.levels.INFO)
        require('nvim-treesitter').update():wait()
        vim.notify('Finished nvim-treesitter update', vim.log.levels.INFO)
    end)
end)
plug(
    { src = 'nvim-treesitter/nvim-treesitter', version = 'main' },
    'nvim-treesitter',
    nil,
    function()
        require('nvim-treesitter').install(require('me.config.treesitter'))

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('Treesitter', { clear = true }),
            pattern = require('me.config.treesitter'),
            callback = function()
                vim.treesitter.start()
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.bo.indentexpr =
                    'v:lua.require"nvim-treesitter".indentexpr()'
            end,
        })
    end
)
plug(
    'nvim-treesitter/nvim-treesitter-context',
    'treesitter-context',
    { max_lines = 3 }
)

plug(
    'folke/which-key.nvim',
    'which-key',
    { preset = 'helix', win = { wo = { winblend = 0 } } }
)

plug('evictedcucumber/lazydev.nvim', 'lazydev', {})

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
plug('Saghen/blink.cmp', 'blink.cmp', require('me.config.blink'), function()
    vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
    })
end)

plug(
    'j-hui/fidget.nvim',
    'fidget',
    { notification = { window = { winblend = 0 } } }
)

plug('stevearc/conform.nvim', 'conform', require('me.config.conform'))

plug('nvim-lualine/lualine.nvim', 'lualine', require('me.config.lualine'))

plug('mikavilpas/yazi.nvim', 'yazi', { open_for_directories = true }, function()
    vim.keymap.set(
        'n',
        '-',
        '<cmd>Yazi<CR>',
        { desc = 'Open Yazi at Current File' }
    )
    vim.keymap.set(
        'n',
        '_',
        '<cmd>Yazi cwd<CR>',
        { desc = 'Open Yazi at Current Working Directory' }
    )
end)

plug('echasnovski/mini.move', 'mini.move', {})

plug(
    'MeanderingProgrammer/render-markdown.nvim',
    'render-markdown',
    require('me.config.render-markdown')
)

plug('obsidian-nvim/obsidian.nvim', 'obsidian', require('me.config.obsidian'))
