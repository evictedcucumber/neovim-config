local M = { 'ThePrimeagen/harpoon' }
M.branch = 'harpoon2'
M.dependencies = 'nvim-lua/plenary.nvim'

M.keys = {
    {
        '<leader>a',
        function()
            require('harpoon'):list():add()
        end,
        desc = 'Harpoon Add',
    },
    {
        '<leader>e',
        function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Explorer',
    },
    {
        '<C-p>',
        function()
            require('harpoon'):list():prev()
        end,
        desc = 'Harpoon Previous',
    },
    {
        '<C-n>',
        function()
            require('harpoon'):list():next()
        end,
        desc = 'Harpoon Next',
    },
}

M.config = function()
    require('harpoon'):setup()
end

return M
