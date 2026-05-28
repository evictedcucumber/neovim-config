if not _G.pack_wrapper.add('folke', 'which-key.nvim') then
    return
end

require('which-key').setup({
    preset = 'helix',
    win = { wo = { winblend = 0 } },
    icons = { mappings = true, icons = {} },
})
