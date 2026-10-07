local M = {}

---@class AddOpts
---@field version? string|vim.VersionRange
---@field name? string
---@field requireable? boolean

---@param author string
---@param plugin string
---@param opts? AddOpts
---@return boolean
M.add = function(author, plugin, opts)
    ---@type string
    local url = 'https://github.com/' .. author .. '/' .. plugin

    ---@type AddOpts
    local opts_safe = opts or {}
    local is_requireable = true
    if opts_safe.requireable ~= nil then
        is_requireable = opts_safe.requireable
    end

    ---@type vim.pack.Spec
    local spec = { src = url }
    if opts_safe.version then
        spec.version = opts_safe.version
    end
    if opts_safe.name then
        spec.name = opts_safe.name
    end

    local added, add_err = pcall(vim.pack.add, { spec }, { confirm = false })
    if not added then
        vim.notify(
            ('pack.add: failed to add "%s": %s'):format(plugin, add_err),
            vim.log.levels.ERROR
        )
        return false
    end

    if is_requireable then
        ---@type string
        local to_require = opts_safe.name or plugin:gsub('%.nvim$', '')

        local required = pcall(require, to_require)
        if not required then
            vim.notify(
                ('pack.add: could not require "%s" (require name "%s")'):format(
                    plugin,
                    to_require
                ),
                vim.log.levels.ERROR
            )
            return false
        end
    end

    return true
end

return M
