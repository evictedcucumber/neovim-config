local M = {}

---@param client vim.lsp.Client
---@param bufnr integer
M.on_attach = function(client, bufnr)
    local lsp_augroup =
        vim.api.nvim_create_augroup('lsp_augroup', { clear = true })

    local function opts(desc)
        ---@type vim.keymap.set.Opts
        return {
            buffer = bufnr,
            desc = desc,
            nowait = true,
            silent = true,
            noremap = true,
        }
    end

    vim.keymap.set('n', 'gd', function()
        require('snacks').picker.lsp_definitions()
    end, opts('[G]o to LSP [D]efinition'))
    vim.keymap.set('n', 'gt', function()
        require('snacks').picker.lsp_type_definitions()
    end, opts('[G]o to LSP [T]ype Definition'))
    vim.keymap.set('n', 'gD', function()
        require('snacks').picker.lsp_declarations()
    end, opts('[G]o to LSP [D]eclaration'))
    vim.keymap.set('n', 'gi', function()
        require('snacks').picker.lsp_implementations()
    end, opts('[G]o to [I]mplementation'))
    vim.keymap.set('n', 'gr', function()
        require('snacks').picker.lsp_references()
    end, opts('[G]o to [R]eferences'))
    vim.keymap.set(
        'n',
        '<leader>rn',
        vim.lsp.buf.rename,
        opts('LSP [R]e[n]ame')
    )
    vim.keymap.set(
        { 'n', 'v' },
        '<leader>ca',
        vim.lsp.buf.code_action,
        opts('Show LSP [C]ode [A]ctions')
    )
    vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({
            focusable = true,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
            border = 'rounded',
        })
    end, opts('Show LSP Hover Documentation'))
    vim.keymap.set('n', '<leader>d', function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            scope = 'cursor',
            border = 'rounded',
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
        })
    end, opts('Show [D]iagnostic in Float'))
    vim.keymap.set('n', '<leader>D', function()
        vim.diagnostic.setloclist()
    end, opts('Show all [D]iagnostics'))

    vim.api.nvim_create_autocmd('InsertEnter', {
        buffer = bufnr,
        group = lsp_augroup,
        callback = function()
            vim.diagnostic.enable(false, { bufnr = bufnr })
        end,
    })
    vim.api.nvim_create_autocmd('InsertLeave', {
        buffer = bufnr,
        group = lsp_augroup,
        callback = function()
            vim.diagnostic.enable(true, { bufnr = bufnr })
        end,
    })

    local formatter_info, _ = require('conform').list_formatters_to_run(bufnr)
    if #formatter_info ~= 0 then
        local conform_opts = {
            bufnr = bufnr,
            lsp_format = 'never',
            timeout_ms = 500,
        }
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup(
                'CONFORM_FORMAT',
                { clear = true }
            ),
            buffer = bufnr,
            callback = function()
                require('conform').format(conform_opts)
            end,
        })

        vim.keymap.set('n', '<leader>fm', function()
            require('conform').format(conform_opts)
        end, opts('Conform [F]or[m]at Buffer'))
    end

    if client:supports_method('textDocument/formatting', bufnr) then
        local conform, _ =
            pcall(vim.api.nvim_get_autocmds, { group = 'CONFORM_FORMAT' })
        if not conform then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup(
                    'LSP_FORMAT',
                    { clear = true }
                ),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                end,
            })

            vim.keymap.set('n', '<leader>fm', function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end, opts('LSP [F]or[m]at Buffer'))
        end
    end
end

M.setup = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
    ---@param server string
    ---@param settings? vim.lsp.Config
    local lsp_setup = function(server, settings)
        settings = settings or {}
        settings.capabilities = settings.capabilities or capabilities
        settings.on_attach = settings.on_attach or M.on_attach

        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
    end

    -- lua-language-server
    lsp_setup('lua_ls', {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = { checkThirdParty = false },
                codeLens = { enable = true },
                completion = { callSnippet = 'Replace' },
                doc = { privateName = { '^_' } },
                hint = {
                    enable = true,
                    setType = false,
                    paramType = true,
                    paramName = 'Disable',
                    semicolon = 'Disable',
                    arrayIndex = 'Disable',
                },
                telemetry = { enable = false },
            },
        },
    })
    -- /lua-language-server
    -- nixd
    lsp_setup('nixd', {
        settings = {
            nixd = { formatting = { command = { 'alejandra' } } },
        },
    })
    -- /nixd
    -- autotools_ls
    lsp_setup('autotools_ls')
    -- /autotools_ls
    -- marksman
    lsp_setup('marksman')
    -- /marksman
    -- taplo
    lsp_setup('taplo')
    -- /taplo
end

return M
