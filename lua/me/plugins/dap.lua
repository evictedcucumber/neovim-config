return {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    event = 'LspAttach',
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        require('which-key').add({ { '<leader>g', group = 'Debu[g]' } })

        vim.keymap.set('n', '<leader>gt', function()
            dapui.toggle()
        end, { desc = 'Debu[g] UI [T]oggle' })

        vim.keymap.set('n', '<leader>gb', function()
            dap.toggle_breakpoint()
        end, { desc = 'Debu[g] Toggle [B]reakpoint' })
        vim.keymap.set('n', '<leader>gc', function()
            dap.continue()
        end, { desc = 'Debu[g] [C]ontinue' })
        vim.keymap.set('n', '<leader>gT', function()
            dap.terminate()
        end, { desc = 'Debu[g] [T]erminate' })

        require('which-key').add({ { '<leader>gs', group = 'Debu[g] [S]tep' } })

        vim.keymap.set('n', '<leader>gsi', function()
            dap.step_into()
        end, { desc = 'Debu[g] [S]tep [I]nto' })
        vim.keymap.set('n', '<leader>gso', function()
            dap.step_over()
        end, { desc = 'Debu[g] [S]tep [O]ver' })
        vim.keymap.set('n', '<leader>gsb', function()
            dap.step_back()
        end, { desc = 'Debu[g] [S]tep [B]ack' })
        vim.keymap.set('n', '<leader>gsO', function()
            dap.step_out()
        end, { desc = 'Debu[g] [S]tep [O]ut' })
    end,
}
