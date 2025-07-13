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

-- configure tabbing
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

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HIGHLIGHT_YANK', { clear = true }),
    desc = 'Highlight area being yanked',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- auto colour column
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('AUTO_COLOR_COLUMN', { clear = true }),
    ---@param ev vim.api.keyset.create_autocmd.callback_args
    callback = function(ev)
        if vim.bo[ev.buf].buflisted then
            if vim.wo.colorcolumn == '' then
                ---@type integer
                local tw = vim.bo[ev.buf].textwidth
                vim.wo.colorcolumn = tw > 0 and tostring(tw) or ''
            end
        end
    end,
})
