---@class me.LspServerSetup
local M = {}

M.server_name = 'nixd'

M.settings = {
    nixd = { formatting = { command = { 'alejandra' } } },
}

return M
