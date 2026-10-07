local pack = require('pack')

if not pack.add('mrcjkb', 'rustaceanvim', { requireable = false }) then
    return
end
-- blink.cmp is added (with its version pin) by plugin/blink.lua
local has_blink, blink = pcall(require, 'blink.cmp')

-- RUST
vim.g.rustaceanvim = {
    tools = {
        ---@type vim.lsp.util.open_floating_preview.Opts
        float_win_config = { border = 'rounded' },
        code_actions = { ui_select_fallback = true },
    },
    server = {
        ---@param bufnr integer
        on_attach = function(_, bufnr)
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
        end,
        capabilities = has_blink and blink.get_lsp_capabilities({
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
        }, true) or nil,
        standalone = false,
    },
}
-- /RUST
