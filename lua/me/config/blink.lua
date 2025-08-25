return {
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
        use_frecency = true,
        use_proximity = true,
    },
    cmdline = {
        keymap = {
            preset = 'inherit',
        },
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
        per_filetype = {
            lua = { inherit_defaults = true, 'lazydev' },
        },
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
}
