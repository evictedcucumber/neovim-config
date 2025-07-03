return {
    'mrcjkb/rustaceanvim',
    dependencies = { 'saghen/blink.cmp' },
    version = '^6',
    lazy = false,
    init = function()
        vim.g.rustaceanvim = {
            tools = {
                ---@type vim.lsp.util.open_floating_preview.Opts
                float_win_config = { border = 'rounded' },
                code_actions = { ui_select_fallback = true }
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

                    vim.keymap.set('n', '<leader>d',
                        '<cmd>RustLsp renderDiagnostic<CR>',
                        opts('Show Rust [D]iagnostic in Float')
                    )

                    vim.keymap.set('n', 'K',
                        '<cmd>RustLsp hover actions<CR>',
                        opts('Show Rust Hover Documentation')
                    )

                    vim.keymap.set('n', '<leader>ca',
                        '<cmd>RustLsp codeAction<CR>',
                        opts('Show Rust [C]ode [A]ctions')
                    )
                end,
                capabilities = require('blink.cmp').get_lsp_capabilities(nil,
                    true),
                standalone = false,
            }
        }
    end
}
