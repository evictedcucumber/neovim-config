local M = {}

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
