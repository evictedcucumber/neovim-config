---@brief
---
--- https://github.com/artempyanykh/marksman
---
--- Marksman is a Markdown LSP server providing completion, cross-references, diagnostics, and more.
---
--- Marksman works on MacOS, Linux, and Windows and is distributed as a self-contained binary for each OS.
---
--- Pre-built binaries can be downloaded from https://github.com/artempyanykh/marksman/releases

---@type vim.lsp.Config
return {
    cmd = { 'marksman', 'server' },
    filetypes = { 'markdown', 'markdown.mdx' },
    ---@param bufnr number
    ---@param on_dir fun(root_dir?: string)
    root_dir = function(bufnr, on_dir)
        local obsidian_path = vim.fn.expand('~/myvault/')
        local name = vim.api.nvim_buf_get_name(bufnr)

        if name:sub(1, #obsidian_path) == obsidian_path then
            return
        end

        return on_dir(vim.fn.getcwd())
    end,
}
