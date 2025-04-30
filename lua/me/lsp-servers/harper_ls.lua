---@class me.LspServerSetup
local M = {}

M.server_name = 'harper_ls'

M.settings = {
    ['harper-ls'] = {
        userDictPath = vim.fn.stdpath('cache') .. '/harper-ls/dictionary.txt',
        dialetc = 'British',
        codeActions = { ForceStable = true },
        linters = {
            LinkingVerbs = true,
            BoringWords = true,
            UseGenitive = true,
            SpelledNumbers = true,
        },
        markdown = { IgnoreLinkTitle = true },
    },
}

return M
