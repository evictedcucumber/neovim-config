require('blink.cmp').setup({
    completion = {
        list = {
            selection = {
                preselect = true,
            },
            cycle = {
                from_bottom = false,
                from_top = false,
            },
        },
        menu = {
            scrolloff = 4,
            scrollbar = false,
            draw = {
                columns = {
                    { 'label', 'label_description', gap = 1 },
                    { 'kind_icon' },
                },
            },
        },
        documentation = {
            auto_show = true,
        },
        ghost_text = {
            enabled = true,
        },
    },
    signature = {
        enabled = true,
    },
    fuzzy = {
        implementation = 'rust',
    },
    cmdline = {
        keymap = {
            preset = 'inherit',
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
                    if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
                        return 3
                    else
                        return 0
                    end
                end,
            },
        },
    },
})
