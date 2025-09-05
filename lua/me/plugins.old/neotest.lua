return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
        'mrcjkb/rustaceanvim',
    },
    setup = function()
        require('neotest').setup({
            adapters = {
                require('rustaceanvim.neotest'),
            },
        })
    end,
}
