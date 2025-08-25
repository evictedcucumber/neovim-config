---@brief
---
--- https://github.com/Freed-Wu/autotools-language-server
---
--- `autotools-language-server` can be installed via `pip`:
--- ```sh
--- pip install autotools-language-server
--- ```
---
--- Language server for autoconf, automake and make using tree sitter in python.

---@type vim.lsp.Config
return {
    cmd = { 'autotools-language-server' },
    filetypes = { 'config', 'automake', 'make' },
    root_markers = { 'configure.ac', 'Makefile', 'Makefile.am', '*.mk' },
}
