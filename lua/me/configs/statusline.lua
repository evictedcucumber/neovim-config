require('mini.statusline').setup({
    content = {
        active = function()
            local mode, mode_hl =
                MiniStatusline.section_mode({ trunc_width = 0 })
            local git = MiniStatusline.section_git({ trunc_width = 0 })
            local filename =
                MiniStatusline.section_filename({ trunc_width = math.huge })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 0 })
            local fileinfo =
                MiniStatusline.section_fileinfo({ trunc_width = math.huge })
            local location =
                MiniStatusline.section_location({ trunc_width = math.huge })
            local search =
                MiniStatusline.section_searchcount({ trunc_width = 0 })

            return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git } },
                '%<',
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=',
                { hl = 'MiniStatuslineFilename', strings = { lsp } },
                '%<',
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                {
                    hl = mode_hl,
                    strings = { search, location },
                },
            })
        end,
    },
})
