local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

require('luasnip.loaders.from_vscode').lazy_load({ include = { 'lua', 'cpp', 'cmake' } })

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noselect',
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            scrollbar = false,
            winhighlight = 'Normal:CmpNormal',
        }),
        documentation = cmp.config.window.bordered({
            side_padding = 0,
            winhighlight = 'Normal:CmpDocNormal',
        }),
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm({ select = false })
                end
            else
                fallback()
            end
        end),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        expandable_indicator = true,
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = {
                menu = 50,
                abbr = 50,
            },
            ellipsis_char = '...',
            show_lableDetails = true,
        }),
    },
})

local cmdline_mapping = {
    ['<C-k>'] = { c = cmp.mapping.select_prev_item() },
    ['<C-j>'] = { c = cmp.mapping.select_next_item() },
    ['<C-e>'] = { c = cmp.mapping.abort() },
    ['<CR>'] = { c = cmp.mapping.confirm({ select = false }) },
}

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmdline_mapping,
    sources = {
        { name = 'buffer' },
    },
})

cmp.setup.cmdline(':', {
    mapping = cmdline_mapping,
    sources = cmp.config.sources({
        { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } },
        { name = 'path' },
    }),
})
