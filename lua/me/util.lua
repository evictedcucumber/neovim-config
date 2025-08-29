local M = {}

---@param spec string|vim.pack.Spec
---@param require_name string
---@param opts? table
---@param config? fun():nil
function M.plugin(spec, require_name, opts, config)
    if type(spec) == 'string' then
        spec = { src = 'https://github.com/' .. spec }
    elseif type(spec) == 'table' then
        spec.src = 'https://github.com/' .. spec.src
    else
        vim.notify('Invaild plugin name or spec given', vim.log.levels.ERROR)
        return
    end

    local add_ok, err = pcall(vim.pack.add, { spec })
    if not add_ok then
        vim.notify('Faild to add plugin: ' .. err, vim.log.levels.ERROR)
        return
    end

    local require_ok, required = pcall(require, require_name)
    if not require_ok then
        vim.notify(
            'Unable to require plugin with name `' .. require_name .. '`',
            vim.log.levels.ERROR
        )
        return
    end

    if opts then
        local setup_ok, _ = pcall(required.setup, opts)
        if not setup_ok then
            vim.notify(
                'Unabe to call setup for plugin `' .. require_name .. '`',
                vim.log.levels.ERROR
            )
            return
        end
    end

    if config then
        local config_ok, _ = pcall(config)
        if not config_ok then
            vim.notify(
                'Unable to call config for plugin `' .. require_name .. '`',
                vim.log.levels.ERROR
            )
        end
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
