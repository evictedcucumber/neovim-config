local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')

telescope.setup({
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            prompt_position = 'top',
            horizontal = { width = 0.9 },
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = {
            '.git',
            '.git/',
            '*cache*',
        },
        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-b>'] = actions.preview_scrolling_down,
                ['<C-f>'] = actions.preview_scrolling_up,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        live_grep = {
            additional_args = { '--hidden' },
        },
        spell_suggest = {
            theme = 'cursor',
        },
        current_buffer_fuzzy_find = {
            theme = 'cursor',
            layout_strategy = 'center',
            layout_config = {
                prompt_position = 'bottom',
                preview_cutoff = math.huge,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        },
        ['ui-select'] = {
            themes.get_cursor(),
        },
    },
})

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtins = require('telescope.builtin')

local function is_git_repo()
    vim.fn.system('git rev-parse --is-inside-work-tree')
    return vim.v.shell_error == 0
end

local function get_git_cwd()
    local cwd = vim.fn.system('git rev-parse --show-toplevel')
    return vim.fn.trim(cwd, '\n', 2)
end

local function find_files_from_project_git_root()
    local opts = {}
    if is_git_repo() then
        opts = {
            cwd = get_git_cwd(),
        }
    end
    builtins.find_files(opts)
end

local function live_grep_from_project_git_root()
    local opts = {}
    if is_git_repo() then
        opts = {
            cwd = get_git_cwd(),
        }
    end
    builtins.live_grep(opts)
end

vim.keymap.set('n', '<leader>sf', find_files_from_project_git_root, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>sg', live_grep_from_project_git_root, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>ss', builtins.spell_suggest, { desc = 'Spell Suggest' })
vim.keymap.set('n', '<leader>sb', builtins.buffers, { desc = 'Search Buffers' })
vim.keymap.set(
    'n',
    '<leader>/',
    builtins.current_buffer_fuzzy_find,
    { desc = 'Fuzzy Search Current Buffer' }
)
