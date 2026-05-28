local plugins_dir = vim.fn.stdpath('config') .. '/lua/me/plugins'

for _, file in ipairs(vim.fn.readdir(plugins_dir)) do
    if file:match('%.lua$') and file ~= 'init.lua' then
        local module = file:gsub('%.lua$', '')
        require('me.plugins.' .. module)
    end
end

local filetype_plugins_dir = vim.fn.stdpath('config')
    .. '/lua/me/plugins/filetype'

for _, file in ipairs(vim.fn.readdir(filetype_plugins_dir)) do
    if file:match('%.lua$') then
        local module = file:gsub('%.lua$', '')
        require('me.plugins.filetype.' .. module)
    end
end
