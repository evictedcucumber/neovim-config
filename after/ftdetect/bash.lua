vim.filetype.add({
    pattern = {
        ['.*'] = function(_, bufnr)
            local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]

            if
                first_line:match('^#!.*/bin/env%s+bash')
                or first_line:match('^#!.*/bin/bash')
            then
                return 'bash'
            end
        end,
    },
})
