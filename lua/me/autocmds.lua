-- restore last cursor position when reopening a file
local last_cursor_group =
    vim.api.nvim_create_augroup('LastCursorGroup', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
    group = last_cursor_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- remember cursor positon when switching buffers
vim.api.nvim_create_autocmd('BufLeave', {
    group = last_cursor_group,
    callback = function(ev)
        vim.b[ev.buf].last_cursor = vim.api.nvim_win_get_cursor(0)
    end,
})
vim.api.nvim_create_autocmd('BufEnter', {
    group = last_cursor_group,
    callback = function(ev)
        if vim.b[ev.buf].last_cursor then
            pcall(vim.api.nvim_win_set_cursor, 0, vim.b[ev.buf].last_cursor)
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
