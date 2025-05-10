---A representation of a custom table for LSP server setup.
---@class me.LspServerSetup
---@field server_name string
---@field disabled? boolean
---@field on_init? fun():nil
---@field filetypes? table<string>
---@field capabilities? table
---@field cmd? table
---@field init_options? table
---@field settings? table

---A global class used to store any personal global functions or variables.
---@class Me
_G.Me = {}

---Create a custom augroup with the `Me` prefix.
---@param name string
---@nodiscard
---@return integer
---@see vim.api.nvim_create_augroup
Me.custom_augroup = function(name)
    return vim.api.nvim_create_augroup('Me' .. name, { clear = true })
end
