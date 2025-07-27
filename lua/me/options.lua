-- enable true color support
vim.o.termguicolors = true

-- using dark background
vim.o.background = 'dark'

-- disable default providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0

-- enable relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- configure tabbing
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.breakindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- disable wrapping
vim.o.wrap = false

-- configure search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- highlight line under cursor
vim.o.cursorline = true

-- permanently show sign column
vim.o.signcolumn = 'yes'

-- configure backspace key in insert mode
vim.o.backspace = 'indent,eol,start'

-- disable swapfile
vim.o.swapfile = false

-- enable mouse support
vim.o.mouse = ''

-- enable undofile
vim.o.undofile = true
vim.o.undodir = os.getenv('XDG_STATE_HOME') .. '/nvim/undo//'

-- show substitution preview in new split
vim.o.inccommand = 'split'

-- ensure lines are present above and below cursor
vim.o.scrolloff = 12

-- configure timeout
vim.o.timeout = true
vim.o.timeoutlen = 500

-- disable showmode
vim.o.showmode = false

-- display whitespace as certain characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- configure splits
vim.o.splitright = true
vim.o.splitbelow = true

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
