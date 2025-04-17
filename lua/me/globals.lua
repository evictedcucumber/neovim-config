---@meta _

---@class me.LspServer
---@field lsp? fun(capabilities: table, on_attach: function):nil
---@field formatter? fun(formatters_by_ft: table<string, any>):nil
---@field custom_augroup fun(name: string): integer
---@field linter? fun(linters_by_ft: table<string, string[]>):nil

---@class Me
---@see Me.custom_augroup
---@see Me.setup_lsp
_G.Me = {}

---Create a custom augroup with the `Me` prefix.
---
---@param name string
---
---@nodiscard
---@return integer
---
---@see vim.api.nvim_create_augroup
Me.custom_augroup = function(name)
    return vim.api.nvim_create_augroup('Me' .. name, { clear = true })
end

---Configure and enable a given LSP server with given settings.
---
---@param name string
---@param settings vim.lsp.Config
---
---@return nil
---
---@see vim.lsp.config
Me.setup_lsp = function(name, settings)
    vim.lsp.config(name, settings)
    vim.lsp.enable(name)
end
