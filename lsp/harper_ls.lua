---@brief
---
--- https://github.com/automattic/harper
---
--- The language server for Harper, the slim, clean language checker for developers.
---
--- See our [documentation](https://writewithharper.com/docs/integrations/neovim) for more information on settings.
---
--- In short, they should look something like this:
--- ```lua
--- vim.lsp.config('harper_ls', {
---   settings = {
---     ["harper-ls"] = {
---       userDictPath = "~/dict.txt"
---     }
---   },
--- })
--- ```

local workspace_dict_path = '.harper-dictionary.txt'
if vim.fn.getcwd() == vim.fn.expand('~/myvault') then
    workspace_dict_path = '.obsidian/harper-dictionary.json'
end

---@type vim.lsp.Config
return {
    cmd = { 'harper-ls', '--stdio' },
    filetypes = { 'markdown' },
    root_markers = { '.git' },
    settings = {
        ['harper-ls'] = {
            dialect = 'British',
            workspaceDictPath = workspace_dict_path,
            userDictPath = vim.fn.stdpath('config')
                .. '/.user-harper-dictionary.txt',
        },
    },
}
