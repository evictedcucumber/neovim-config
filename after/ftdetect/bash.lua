vim.filetype.add({
    pattern = {
        ['.*'] = function(_, bufnr)
            local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]

            if first_line == '#!/usr/bin/env bash' then
                return 'bash'
            end
        end,
    },
})
