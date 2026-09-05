local pack = require('pack')

if not pack.add('folke', 'snacks.nvim') then
    return
end

local exclude = {
    '**/*.lock',
    '**/build/',
    '**/.cache/',
    '**/target/',
    '**/.trash/',
    '**/.direnv/',
}
require('snacks').setup({
    picker = {
        layout = { preset = 'ivy' },
        matcher = { cwd_bonus = true, frecency = true },
        sources = {
            grep = { hidden = true, exclude = exclude },
            files = { hidden = true, exclude = exclude },
        },
    },
    explorer = { replace_netrw = true },
    indent = { animate = { enabled = false } },
    quickfile = { enabled = true },
    input = { enabled = true },
    image = { enabled = true },
    notifier = { enabled = true },
})

-- LSP progress via the notifier, replacing fidget.nvim
vim.api.nvim_create_autocmd('LspProgress', {
    callback = function(ev)
        local spinner = {
            '⠋',
            '⠙',
            '⠹',
            '⠸',
            '⠼',
            '⠴',
            '⠦',
            '⠧',
            '⠇',
            '⠏',
        }
        vim.notify(vim.lsp.status(), 'info', {
            id = 'lsp_progress',
            title = 'LSP Progress',
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == 'end' and ' '
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

vim.keymap.set('n', '-', function()
    require('snacks').explorer.open()
end, { desc = 'Open File Explorer' })

vim.keymap.set('n', '<leader>sf', function()
    require('snacks').picker.files()
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', function()
    require('snacks').picker.grep()
end, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sh', function()
    require('snacks').picker.help()
end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function()
    require('snacks').picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sb', function()
    require('snacks').picker.buffers()
end, { desc = '[S]earch [B]uffers' })
