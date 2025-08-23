-- line numbers
vim.o.number = true -- line numbers
vim.o.relativenumber = true -- relative line numbers

-- cursor
vim.o.cursorline = true -- highlight current line
vim.o.scrolloff = 10 -- always keep this many lines above and below the cursor
vim.o.sidescrolloff = 10 -- always keep this many columns left and right of the cursor
vim.o.wrap = false -- disable line wrap

-- visuals
vim.o.cmdheight = 1 -- set cmdline height
vim.o.termguicolors = true -- enable 24-bit colors
vim.o.signcolumn = 'yes' -- always display sign column
vim.o.colorcolumn = '80' -- set colour column to 80 columns
vim.o.showmode = false -- do not show current mode in cmdline
vim.o.pumheight = 10 -- popup menu height
vim.o.pumblend = 0 -- popup menu transparency
vim.o.winblend = 0 -- floating window transparency
vim.o.conceallevel = 0 -- do not hide markup
vim.o.concealcursor = '' -- show markup even on cursor line
vim.o.lazyredraw = false -- redraw while executing macros
vim.o.redrawtime = 10000 -- time for syntax highlighting redraw
vim.o.maxmempattern = 20000 -- max memory for pattern matching
vim.o.synmaxcol = 300 -- max syntax highlighting column limit
vim.o.list = true -- show tabs, trailing and newline characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- the characters to represent the tab, space, and newline

-- file handling
vim.o.backup = false -- disable backup files
vim.o.writebackup = false -- disable backup before overwrite
vim.o.swapfile = false -- disable swapfile
vim.o.undofile = true -- enable undofile
vim.o.updatetime = 300 -- time to trigger "CursorHold"
vim.o.timeoutlen = 500 -- time to wait for mapped sequence
vim.o.autoread = true -- auto-reload external changes
vim.o.autowrite = false -- do not auto-save during some events

-- diffing
vim.opt.diffopt:append('vertical') -- vertical diff splits
vim.opt.diffopt:append('algorithm:patience') -- better diff algorithm
vim.opt.diffopt:append('linematch:60') -- better syntax highlighting

-- completetion
vim.o.completeopt = 'menuone,noinsert,noselect' -- completion options

-- spelling
vim.o.spelllang = 'en' -- set spell language to english

-- tabs
vim.o.tabstop = 4 -- width of tab character
vim.o.shiftwidth = 4 -- width of single level of indentation
vim.o.softtabstop = 4 -- width of soft tabs
vim.o.expandtab = true -- convert tab characters to equivalent spaces
vim.o.smarttab = false -- disable smart tabbing

-- indentation
vim.o.smartindent = true -- smart auto indenting
vim.o.autoindent = true -- auto indent lines based on line above
vim.o.breakindent = false -- disable same indent line breaking

-- grep
vim.o.grepprg = 'rg --vimgrep' -- use ripgrep as default grep
vim.o.grepformat = '%f:%l:%c:%m' -- filename, line number, column number, content

-- search
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- match exact case if starts with capital letter
vim.o.hlsearch = false -- do not highlight search results
vim.o.incsearch = true -- show search results while typing
vim.o.inccommand = 'split' -- show substitution inside split

-- behaviour
vim.o.errorbells = false -- disable error sounds
vim.o.backspace = 'indent,eol,start' -- make backspace behave naturally
vim.o.autochdir = false -- disable auto directory change
vim.opt.iskeyword:append('-') -- make `-` part of word
vim.opt.path:append('**') -- search within subfolders
vim.o.selection = 'inclusive' -- use inclusive selection
vim.o.mouse = '' -- disable mouse
vim.o.encoding = 'UTF-8' -- set utf-8 encoding
vim.o.wildmenu = true -- enable cmdline completion menu
vim.o.wildmode = 'longest:full,full' -- completion mode for cmdline
vim.o.wildignorecase = true -- case-insensitive completion for cmdline
vim.o.splitbelow = true -- horizontal splits go below
vim.o.splitright = true -- vertical splits go right

-- folding
vim.o.foldmethod = 'expr' -- use expression for folding
vim.o.foldexpr = 'v:lua.vim.treesiter.foldexpr()' -- use treesitter
vim.o.foldlevel = 99 -- open all folds on startup
