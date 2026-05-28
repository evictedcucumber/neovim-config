vim.g.pack_confirm = false

local M = {}

local log = require('pack.plenary_log')

---@class AddOpts
---@field version? string|vim.VersionRange
---@field name? string
---@field requireable? boolean

---@param author string
---@param plugin string
---@param opts? AddOpts
---@return boolean
M.add = function(author, plugin, opts)
    log.debug(
        'function "add" called: ',
        author,
        plugin,
        vim.inspect(opts, { indent = '', newline = ' ' })
    )

    ---@type string
    local url = 'https://github.com/' .. author .. '/' .. plugin
    log.debug('plugin url: ', url)

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
        log.error('failed to add plugin with error: ', add_err)
        return false
    end

    if is_requireable then
        ---@type string
        local to_require = opts_safe.name or plugin:gsub('%.nvim$', '')
        log.debug('plugin require_name: ', to_require)

        local required, _ = pcall(require, to_require)
        if not required then
            log.error(
                'could not require plugin: ',
                vim.inspect(
                    { name = plugin, require_name = to_require },
                    { indent = '', newline = ' ' }
                )
            )
            return false
        end
        log.debug('can require plugin: ', plugin)
    end

    return true
end

return M
