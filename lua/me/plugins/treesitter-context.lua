local M = { 'nvim-treesitter/nvim-treesitter-context' }
M.dependencies = 'nvim-treesitter/nvim-treesitter'

M.event = { 'BufReadPre', 'BufNewFile' }

M.opts = { max_lines = 3 }

return M
