return {
    'mrcjkb/rustaceanvim',
    dependencies = { 'saghen/blink.cmp' },
    version = '^6',
    lazy = false,
    init = function()
        local capabilities =
            require('blink.cmp').get_lsp_capabilities(nil, true)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        vim.g.rustaceanvim = {
            tools = {
                ---@type vim.lsp.util.open_floating_preview.Opts
                float_win_config = { border = 'rounded' },
                code_actions = { ui_select_fallback = true },
            },
            server = {
                ---@param client vim.lsp.Client
                ---@param bufnr integer
                on_attach = function(client, bufnr)
                    require('me.lsp').on_attach(client, bufnr)

                    ---@param desc string
                    ---@return vim.keymap.set.Opts opts
                    local opts = function(desc)
                        return {
                            desc = desc,
                            buffer = bufnr,
                            silent = true,
                            nowait = true,
                            noremap = true,
                        }
                    end

                    vim.keymap.set(
                        'n',
                        '<leader>d',
                        '<cmd>RustLsp renderDiagnostic current<CR>',
                        opts('Show Rust [D]iagnostic in Float')
                    )
                    vim.keymap.set(
                        'n',
                        '[d',
                        '<cmd>RustLsp renderDiagnostic cycle_prev<CR>',
                        opts('Goto Previous [D]iagnostic')
                    )
                    vim.keymap.set(
                        'n',
                        ']d',
                        '<cmd>RustLsp renderDiagnostic cycle<CR>',
                        opts('Goto Next [D]iagnostic')
                    )

                    vim.keymap.set(
                        'n',
                        'K',
                        '<cmd>RustLsp hover actions<CR>',
                        opts('Show Rust Hover Documentation')
                    )

                    vim.keymap.set(
                        'n',
                        '<leader>ca',
                        '<cmd>RustLsp codeAction<CR>',
                        opts('Show Rust [C]ode [A]ctions')
                    )

                    vim.keymap.set(
                        'n',
                        '<leader>cr',
                        '<cmd>RustLsp! runnables<CR>',
                        opts('Run Rust [R]unnables')
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>cR',
                        '<cmd>RustLsp runnables<CR>',
                        opts('Select and Run Rust [R]unnables')
                    )

                    vim.keymap.set(
                        'n',
                        '<leader>ct',
                        '<cmd>RustLsp! testables<CR>',
                        opts('Run Rust [T]estables')
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>cT',
                        '<cmd>RustLsp testables<CR>',
                        opts('Select and Run Rust [T]estables')
                    )

                    vim.keymap.set(
                        'n',
                        '<leader>cd',
                        '<cmd>RustLsp! debuggables<CR>',
                        opts('Run Rust [D]ebuggables')
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>cD',
                        '<cmd>RustLsp debuggables<CR>',
                        opts('Select and Run Rust [D]ebuggables')
                    )
                end,
                capabilities = capabilities,
                standalone = false,
            },
        }
    end,
}
