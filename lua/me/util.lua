local M = {}

---@class me.Plugin
---@field src string
---@field name? string
---@field version? string|vim.VersionRange

---@param src string
---@param name? string
---@param version? string|vim.VersionRange
function M.add_plugin(src, name, version)
    ---@type vim.pack.Spec
    local spec = { src = 'https://github.com/' .. src }
    if name then
        spec.name = name
    end
    if version then
        spec.version = version
    end

    local ok, err = pcall(vim.pack.add, { spec }, { confirm = false })
    if not ok then
        vim.print(err)
    end
end

---@param plugins me.Plugin[]
function M.add_plugins(plugins)
    for _, plugin in ipairs(plugins) do
        M.add_plugin(plugin.src, plugin.name, plugin.version)
    end
end

---@param name string
---@param opts table
function M.safe_setup(name, opts)
    local require_ok, require_value = pcall(require, name)
    if not require_ok then
        vim.print(require_value)
        return
    end

    local setup_ok, err = pcall(require_value.setup, opts)
    if not setup_ok then
        vim.print(err)
        return
    end
end

---@class me.PostInstallUpdateHook
---@field name string
---@field hook fun():nil

---@type me.PostInstallUpdateHook[]
M.post_pack_install_update_hooks = {}

---@param name string
---@param hook fun(path: string):nil
function M.add_post_pack_install_update_hook(name, hook)
    table.insert(M.post_pack_install_update_hooks, { name = name, hook = hook })
end

return M
