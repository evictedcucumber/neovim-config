if not _G.pack_wrapper.add('stevearc', 'conform.nvim') then
    return
end

---@type conform.FormatOpts
local conform_format_opts = { lsp_format = 'fallback', timeout_ms = 500 }
require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        make = { 'bake' },
        go = { 'gofmt' },
        toml = { 'taplo' },
        yaml = { 'yamlfix' },
        json = { 'prettierd' },
    },
    format_on_save = function(buffer)
        local disabled_filetypes = {}
        if disabled_filetypes[vim.bo[buffer].filetype] then
            return nil
        end

        return conform_format_opts
    end,
})
_G.keymap('n', '<leader>fm', function()
    require('conform').format(conform_format_opts)
end, { desc = '[F]or[m]at Buffer' })
