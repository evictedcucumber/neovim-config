-- enable true color support
vim.opt.termguicolors = true

-- using dark background
vim.opt.background = 'dark'

-- disable default providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0

-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- enable colour column
vim.opt.colorcolumn = '100'

-- configure tabbing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.breakindent = true

-- disable wrapping
vim.opt.wrap = false

-- configure search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- highlight line under cursor
vim.opt.cursorline = true

-- permanently show sign column
vim.opt.signcolumn = 'yes'

-- configure backspace key in insert mode
vim.opt.backspace = 'indent,eol,start'

-- enable swapfile
vim.opt.swapfile = true

-- enable mouse support
vim.opt.mouse = 'a'

-- enable undofile
vim.opt.undofile = true
vim.opt.undodir = os.getenv('XDG_STATE_HOME') .. '/nvim/undo//'

-- show substitution preview in new split
vim.opt.inccommand = 'split'

-- ensure lines are present above and below cursor
vim.opt.scrolloff = 12

-- enable spellcheck
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'en_gb' }

-- configure timeout
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- disable showmode
vim.opt.showmode = false

-- display whitespace as certain characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- configure splits
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.api.nvim_create_autocmd('TextYankPost', {
    group = _G.custom_augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})
