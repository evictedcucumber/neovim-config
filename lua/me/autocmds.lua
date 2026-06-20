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
        vim.hl.hl_op({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

-- ensure ansible yaml files are detected as yaml.ansible
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = {
        '**/playbooks/**/*.yml',
        '**/inventory/**/*.yml',
        '**/group_vars/**/*.yml',
        '**/host_vars/**/*.yml',
        '**/roles/**/*.yml',
    },
    callback = function()
        vim.bo.filetype = 'yaml.ansible'
    end,
})

-- -- plugin install/update auto executes
-- vim.api.nvim_create_autocmd('PackChanged', {
--     group = vim.api.nvim_create_augroup('PackChangedHook', { clear = true }),
--     callback = function(ev)
--         local name, kind = ev.data.spec.name, ev.data.kind
--
--         if name == 'nvim-treesitter' and kind == 'update' then
--             require('nvim-treesitter').update():wait()
--             return
--         end
--
--         if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
--             ---@diagnostic disable-next-line:undefined-field
--             require('blink.cmp').build():wait(60000)
--         end
--     end,
-- })
