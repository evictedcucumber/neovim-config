if not _G.pack_wrapper.add('j-hui', 'fidget.nvim') then
    return
end

require('fidget').setup({
    notification = { override_vim_notify = true, window = { winblend = 0 } },
})
