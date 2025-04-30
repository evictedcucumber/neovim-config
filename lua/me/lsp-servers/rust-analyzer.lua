---@class me.LspServerSetup
local M = {}

M.server_name = 'rust_analyzer'

M.on_init = function()
    vim.opt.colorcolumn = '99'
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
end

M.settings = {
    ['rust-analyzer'] = {
        cargo = { allFeatures = true },
    },
}

return M
