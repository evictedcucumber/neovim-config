local exclude = {
    '**/*.lock',
    '**/build/',
    '**/.cache/',
    '**/target/',
    '**/docs/',
    '**/doc/api/',
    '**/.trash/',
}

return {
    picker = {
        layout = { preset = 'ivy' },
        matcher = {
            cwd_bonus = true,
            freceny = true,
        },
        sources = {
            grep = {
                hidden = true,
                exclude = exclude,
            },
            files = {
                hidden = true,
                exclude = exclude,
            },
        },
    },
    indent = {
        animate = {
            enabled = false,
        },
    },
    quickfile = {
        enabled = true,
    },
    input = {
        enabled = true,
    },
}
