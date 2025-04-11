require('blink.cmp').setup({
    completion = {
        accept = { create_undo_point = true },
        list = {
            cycle = {
                from_bottom = false,
                from_top = false,
            },
        },
        menu = {
            enabled = true,
            border = 'rounded',
            winblend = vim.o.pumblend,
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
            window = {
                border = 'rounded',
            },
        },
    },
    signature = {
        enabled = true,
        window = {
            border = 'rounded',
            winblend = vim.o.pumblend,
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
            preset = 'cmdline',
        },
        completion = {
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
        ['<C-c>'] = { 'show', 'fallback' },
        ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
    snippets = {
        preset = 'luasnip',
    },
    sources = {
        providers = {
            cmdline = {
                min_keyword_length = function(ctx)
                    if
                        ctx.mode == 'cmdline'
                        and string.find(ctx.line, ' ') == nil
                    then
                        return 3
                    else
                        return 0
                    end
                end,
            },
        },
    },
})
