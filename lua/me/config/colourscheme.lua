return {
    flavour = 'mocha',
    background = { dark = 'mocha' },
    show_end_of_buffer = true,
    default_integrations = true,
    float = {
        transparent = true,
    },
    term_colors = true,
    integrations = {
        snacks = {
            enabled = true,
            indent_scope_color = 'lavendar',
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        blink_cmp = {
            style = 'bordered',
        },
        native_lsp = {
            enabled = true,
            inlay_hints = {
                background = true,
            },
        },
        render_markdown = true,
    },
}
