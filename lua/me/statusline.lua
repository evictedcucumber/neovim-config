local M = {}

local palette, bg_base
local last_mode_key

-- dracula may not be on the runtimepath yet (e.g. `plugin/*.lua` auto-sourcing
-- can trigger a redraw, via vim.pack's own install notifications, before
-- `plugin/colourscheme.lua` has run) so this must tolerate being called early
-- and retry on a later render() instead of throwing, which would otherwise
-- reset 'statusline' to its default for the rest of the session.
local function init()
    if palette then
        return true
    end
    -- set by dracula/vim's autoload script once the colorscheme has loaded;
    -- entries are `{ hex, cterm }` pairs, so keep just the hex
    local p = vim.g['dracula#palette']
    if not p then
        return false
    end
    palette = {}
    for k, v in pairs(p) do
        palette[k] = type(v) == 'table' and v[1] or v
    end

    local transparency = vim.g.dracula_colorterm == 0
    bg_base = transparency and 'NONE' or palette.bgdark

    vim.api.nvim_set_hl(0, 'MeStatusC', { bg = bg_base, fg = palette.fg })
    vim.api.nvim_set_hl(
        0,
        'MeStatusInactive',
        { bg = bg_base, fg = palette.comment }
    )
    return true
end

-- mode -> { label, dracula palette key }
local mode_map = {
    n = { 'NORMAL', 'pink' },
    i = { 'INSERT', 'green' },
    v = { 'VISUAL', 'purple' },
    V = { 'V-LINE', 'purple' },
    ['\22'] = { 'V-BLOCK', 'purple' },
    s = { 'SELECT', 'purple' },
    S = { 'S-LINE', 'purple' },
    R = { 'REPLACE', 'orange' },
    c = { 'COMMAND', 'red' },
    t = { 'TERMINAL', 'red' },
}

local function mode_info()
    local m = vim.fn.mode()
    local entry = mode_map[m] or mode_map[m:sub(1, 1)]
    if not entry then
        return { name = m:upper(), color = palette.pink }
    end
    return { name = entry[1], color = palette[entry[2]] }
end

local function update_mode_hl(key, color)
    if key == last_mode_key then
        return
    end
    last_mode_key = key
    vim.api.nvim_set_hl(
        0,
        'MeStatusModeA',
        { bg = color, fg = palette.bg, bold = true }
    )
    vim.api.nvim_set_hl(
        0,
        'MeStatusModeB',
        { bg = palette.selection, fg = color }
    )
end

-- `:colorscheme` clears custom highlight groups; re-create them on next render
vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('MeStatuslineColors', { clear = true }),
    callback = function()
        palette, last_mode_key = nil, nil
    end,
})

-- git branch, cached per directory (avoids reading .git/HEAD on every redraw)
local branch_cache = {}

local function resolve_git_dir(start_dir)
    local dot_git = vim.fs.find('.git', { path = start_dir, upward = true })[1]
    if not dot_git then
        return nil
    end
    local stat = vim.uv.fs_stat(dot_git)
    if stat and stat.type == 'directory' then
        return dot_git
    end
    -- worktrees/submodules: `.git` is a file containing "gitdir: <path>"
    local first_line = vim.fn.readfile(dot_git, '', 1)[1]
    local gitdir = first_line and first_line:match('^gitdir:%s*(.+)$')
    if not gitdir then
        return nil
    end
    if not vim.startswith(gitdir, '/') then
        gitdir = vim.fs.joinpath(vim.fs.dirname(dot_git), gitdir)
    end
    return gitdir
end

local function read_branch(dir)
    local git_dir = resolve_git_dir(dir)
    if not git_dir then
        return nil
    end
    local head = vim.fn.readfile(vim.fs.joinpath(git_dir, 'HEAD'), '', 1)[1]
    if not head then
        return nil
    end
    return head:match('^ref:%s*refs/heads/(.+)$') or head:sub(1, 7)
end

local function refresh_branch()
    branch_cache[vim.fn.getcwd()] = read_branch(vim.fn.getcwd()) or false
end

vim.api.nvim_create_autocmd(
    { 'VimEnter', 'DirChanged', 'FocusGained', 'BufWritePost' },
    {
        group = vim.api.nvim_create_augroup(
            'MeStatuslineBranch',
            { clear = true }
        ),
        callback = refresh_branch,
    }
)

local function branch()
    local dir = vim.fn.getcwd()
    if branch_cache[dir] == nil then
        refresh_branch()
    end
    local b = branch_cache[dir]
    return b and (' ' .. b .. ' ') or ' '
end

local diagnostic_severities = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
}

local function diagnostics(bufnr)
    local counts = vim.diagnostic.count(bufnr)
    -- reuse the sign icons configured in me.lsp
    local signs = vim.diagnostic.config().signs
    local icons = type(signs) == 'table' and signs.text or {}
    local parts = {}
    for _, severity in ipairs(diagnostic_severities) do
        local count = counts[severity]
        if count and count > 0 then
            table.insert(parts, (icons[severity] or '') .. count)
        end
    end
    return #parts > 0 and (' ' .. table.concat(parts, ' ') .. ' ') or ''
end

local plain = ' %f %m%=%y  %l:%c %p%% '

function M.render()
    local current_win = vim.api.nvim_get_current_win()
    local target_win = tonumber(vim.g.statusline_winid) or current_win

    if target_win ~= current_win then
        -- %f/%m/%y/%l/%c/%p are resolved by Nvim against the owning window,
        -- unlike the Lua-computed segments below (mode/branch/diagnostics),
        -- which only ever see the *focused* window/buffer.
        return init() and ('%#MeStatusInactive#' .. plain) or plain
    end

    if not init() then
        return plain
    end

    local mode = mode_info()
    update_mode_hl(mode.name, mode.color)

    return table.concat({
        '%#MeStatusModeA# ',
        mode.name,
        ' ',
        '%#MeStatusModeB#',
        branch(),
        '%#MeStatusC# %f %m',
        '%=',
        '%#MeStatusC#',
        diagnostics(0),
        '%#MeStatusModeB# %y ',
        '%#MeStatusModeA# %l:%c %p%% ',
    })
end

vim.o.statusline = '%!v:lua.require("me.statusline").render()'

return M
