-- restore last cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('LastCursorGroup', { clear = true }),
    callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        if ft == 'gitcommit' or ft == 'gitrebase' then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(ev.buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- highlight the yanked text for 200ms
local highlight_yank_group =
    vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_yank_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

-- plugin install/update auto executes
vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('PackChangedHook', { clear = true }),
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'nvim-treesitter' and kind == 'update' then
            require('nvim-treesitter').update():wait()
        end
    end,
})
