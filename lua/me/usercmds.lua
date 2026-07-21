vim.api.nvim_create_user_command(
    'BlinkInstall',
    'lua require("blink.cmp").build():wait(60000)',
    {}
)
