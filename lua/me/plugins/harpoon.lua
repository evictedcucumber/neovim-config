return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    keys = {
        {
            '<leader>a',
            function()
                require('harpoon'):list():add()
            end,
            desc = 'Harpoon [A]dd',
        },
        {
            '<leader>e',
            function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = 'Harpoon [E]xplorer',
        },
        {
            '<C-p>',
            function()
                require('harpoon'):list():prev({ ui_nav_wrap = true })
            end,
            desc = 'Harpoon [P]revious',
        },
        {
            '<C-n>',
            function()
                require('harpoon'):list():next({ ui_nav_wrap = true })
            end,
            desc = 'Harpoon [N]ext',
        },
    },
    config = function()
        require('harpoon'):setup()
    end,
}
