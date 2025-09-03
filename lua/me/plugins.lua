---@param specs (string|vim.pack.Spec)[]
local pack_add = function(specs)
    vim.pack.add(specs, { confirm = false })
end
local keymap = vim.keymap.set

local add_post_pack_install_update_hook =
    require('me.util').add_post_pack_install_update_hook

local post_pack_changed_augroup =
    vim.api.nvim_create_augroup('PackPostUpdateOrInstall', { clear = true })
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        local data = args.data or {}
        local kind = data.kind or ''
        local spec = data.spec or {}
        local name = spec.name or ''

        if kind == 'install' or kind == 'update' then
            for _, entry in
                ipairs(require('me.util').post_pack_install_update_hooks)
            do
                local hooked_name, hook = entry.name, entry.hook
                if hooked_name == name then
                    vim.cmd('packadd ' .. hooked_name)
                    hook()
                end
            end
        end
    end,
})

vim.api.nvim_create_user_command('PackUpdate', 'lua vim.pack.update()', {})

pack_add({ 'https://github.com/nvim-lua/plenary.nvim' })

-- ICONS
pack_add({ 'https://github.com/nvim-mini/mini.icons' })
require('mini.icons').setup({})
pack_add({ 'https://github.com/nvim-tree/nvim-web-devicons' })
require('nvim-web-devicons').setup({})
-- /ICONS

pack_add({
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
})
require('catppuccin').setup({
    flavour = 'mocha',
    background = { dark = 'mocha' },
    show_end_of_buffer = true,
    default_integrations = true,
    float = { solid = false, transparent = true },
    term_colors = true,
    integrations = {
        snacks = { enabled = true, indent_scope_color = 'lavender' },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        blink_cmp = { style = 'bordered' },
        native_lsp = { enabled = true, inlay_hints = { background = true } },
        render_markdown = true,
    },
})
vim.cmd('colorscheme catppuccin')

pack_add({ 'https://github.com/evictedcucumber/lazydev.nvim' })
require('lazydev').setup({})

pack_add({ 'https://github.com/folke/snacks.nvim' })
local exclude = {
    '**/*.lock',
    '**/build/',
    '**/.cache/',
    '**/target/',
    '**/docs/',
    '**/doc/api/',
    '**/.trash/',
    '**/.direnv/',
}
require('snacks').setup({
    picker = {
        layout = { preset = 'ivy' },
        matcher = { cwd_bonus = true, freceny = true },
        sources = {
            grep = { hidden = true, exclude = exclude },
            files = { hidden = true, exclude = exclude },
        },
    },
    indent = { animate = { enabled = false } },
    quickfile = { enabled = true },
    input = { enabled = true },
})
keymap('n', '<leader>sf', function()
    require('snacks').picker.files()
end, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sg', function()
    require('snacks').picker.grep()
end, { desc = '[S]earch [G]rep' })
keymap('n', '<leader>sh', function()
    require('snacks').picker.help()
end, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sk', function()
    require('snacks').picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })

add_post_pack_install_update_hook('nvim-treesitter', function()
    vim.schedule(function()
        require('nvim-treesitter').update():wait()
    end)
end)
pack_add({
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'main',
    },
})
local ts_languages = {
    'vim',
    'regex',
    'lua',
    'bash',
    'markdown',
    'markdown-inline',
    'python',
    'editorconfig',
    'rust',
    'toml',
    'make',
    'comment',
    'nix',
    'latex',
    'html',
    'yaml',
}
require('nvim-treesitter').install(ts_languages)
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('Treesitter', { clear = true }),
    pattern = ts_languages,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
    end,
})
pack_add({ 'https://github.com/nvim-treesitter/nvim-treesitter-context' })
require('treesitter-context').setup({ max_lines = 3 })

pack_add({ 'https://github.com/folke/which-key.nvim' })
require('which-key').setup({ preset = 'helix', win = { wo = { winblend = 0 } } })

vim.api.nvim_create_autocmd('PackChanged', {
    group = post_pack_changed_augroup,
    callback = function(ev)
        local data = ev.data
        if not data then
            return
        end

        if data.kind == 'install' or data.kind == 'update' then
            if data.spec.name == 'blink.cmp' then
                vim.notify('is blink')
                vim.schedule(function()
                    vim.system({
                        'nix',
                        'run',
                        '--accept-flake-config',
                        '.#build-plugin',
                    }, {
                        cwd = data.path,
                        stderr = function(_, stderr)
                            if not stderr then
                                return
                            end

                            vim.schedule(function()
                                vim.notify(stderr)
                                -- vim.schedule(function()
                                --     vim.api.nvim_echo({ { data } }, true, {})
                                -- end)
                            end)
                        end,
                    }):wait()
                end)
            end
        end
    end,
})
pack_add({ 'https://github.com/Saghen/blink.cmp' })
require('blink-cmp').setup({
    completion = {
        list = { selection = { preselect = false } },
        accept = { create_undo_point = true },
        menu = {
            enabled = true,
            border = 'rounded',
            scrolloff = 4,
            scrollbar = false,
            draw = {
                columns = {
                    { 'kind_icon' },
                    { 'label', 'label_description', gap = 1 },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            window = { border = 'rounded' },
        },
    },
    signature = {
        enabled = true,
        window = {
            show_documentation = false,
            border = 'rounded',
            treesitter_highlighting = true,
        },
    },
    fuzzy = {
        implementation = 'rust',
        ---@diagnostic disable-next-line:missing-fields
        frecency = { enabled = true },
        use_proximity = true,
    },
    cmdline = {
        keymap = { preset = 'inherit' },
        completion = {
            list = { selection = { preselect = false } },
            menu = {
                auto_show = function()
                    return vim.fn.getcmdtype() == ':'
                end,
            },
        },
    },
    keymap = {
        preset = 'none',
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-e>'] = { 'cancel', 'hide', 'fallback' },
        ['<C-c>'] = { 'show', 'accept', 'fallback' },
        ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
    sources = {
        default = { 'lsp', 'buffer', 'path' },
        per_filetype = { lua = { inherit_defaults = true, 'lazydev' } },
        providers = {
            lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                score_offset = 100,
            },
            cmdline = {
                enabled = function()
                    return vim.fn.getcmdline():sub(1, 1) ~= '!'
                end,
            },
        },
    },
})
vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
})

pack_add({ 'https://github.com/j-hui/fidget.nvim' })
require('fidget').setup({ notification = { window = { winblend = 0 } } })

pack_add({ 'https://github.com/stevearc/conform.nvim' })
require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'prettierd' },
    },
})

pack_add({ 'https://github.com/nvim-lualine/lualine.nvim' })
require('lualine').setup({
    options = {
        theme = 'catppuccin',
        disabled_filetypes = {
            statusline = {
                'dapui_scopes',
                'dapui_breakpoints',
                'dapui_stacks',
                'dapui_watches',
                'dap-repl',
                'dapui_console',
            },
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
    },
})

pack_add({ 'https://github.com/mikavilpas/yazi.nvim' })
require('yazi').setup({ open_for_directories = true })
keymap('n', '-', '<cmd>Yazi<CR>', { desc = 'Open Yazi at Current File' })
keymap(
    'n',
    '_',
    '<cmd>Yazi cwd<CR>',
    { desc = 'Open Yazi at Current Working Directory' }
)

-- MINI PLUGINS
pack_add({
    'https://github.com/nvim-mini/mini.move',
    'https://github.com/nvim-mini/mini.surround',
    'https://github.com/nvim-mini/mini.align',
    'https://github.com/nvim-mini/mini.ai',
})
require('mini.move').setup({})
require('mini.surround').setup({})
require('mini.align').setup({})
require('mini.ai').setup({})
-- /MINI PLUGINS

pack_add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
require('render-markdown').setup({
    preset = 'obsidian',
    completions = { lsp = { enabled = true } },
    render_modes = { 'n', 'c', 't' },
})

pack_add({ 'https://github.com/obsidian-nvim/obsidian.nvim' })
require('obsidian').setup({
    -- TODO: Remove when plugin goes to 4.0
    legacy_commands = false,
    workspaces = { { name = 'myvault', path = '~/myvault' } },
    completion = { nvim_cmp = false, blink = true },
    new_notes_dir = 'current_dir',
    picker = { name = 'snacks.pick' },
    ui = { enable = false },
})

-- RUST
pack_add({ 'https://github.com/mrcjkb/rustaceanvim' })
vim.g.rustaceanvim = {
    tools = {
        ---@type vim.lsp.util.open_floating_preview.Opts
        float_win_config = { border = 'rounded' },
        code_actions = { ui_select_fallback = true },
    },
    server = {
        ---@param bufnr integer
        on_attach = function(_, bufnr)
            ---@param desc string
            ---@return vim.keymap.set.Opts opts
            local opts = function(desc)
                return {
                    desc = desc,
                    buffer = bufnr,
                    silent = true,
                    nowait = true,
                    noremap = true,
                }
            end

            keymap(
                'n',
                '<leader>d',
                '<cmd>RustLsp renderDiagnostic current<CR>',
                opts('Show Rust [D]iagnostic in Float')
            )
            keymap(
                'n',
                '[d',
                '<cmd>RustLsp renderDiagnostic cycle_prev<CR>',
                opts('Goto Previous [D]iagnostic')
            )
            keymap(
                'n',
                ']d',
                '<cmd>RustLsp renderDiagnostic cycle<CR>',
                opts('Goto Next [D]iagnostic')
            )

            keymap(
                'n',
                'K',
                '<cmd>RustLsp hover actions<CR>',
                opts('Show Rust Hover Documentation')
            )

            keymap(
                'n',
                '<leader>ca',
                '<cmd>RustLsp codeAction<CR>',
                opts('Show Rust [C]ode [A]ctions')
            )
        end,
        capabilities = require('blink.cmp').get_lsp_capabilities({
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
        }, true),
        standalone = false,
    },
}
-- /RUST
