local config = {}

function config.crates_nvim()
    require("crates").setup()
end

function config.rust_tools()
    require("rust-tools").setup()
    require("keymaps.langserv.rust")
end

-- function config.flutter_tools()
--     require("flutter-tools").setup()
--     require("keymaps.langserv.flutter")
-- end

function config.peek_nvim()
    local create_cmd = vim.api.nvim_create_user_command

    create_cmd("PeekOpen", require("peek").open, {})
    create_cmd("PeekClose", require("peek").close, {})

    require("peek").setup({
        auto_load = false,
        close_on_bdelete = true,
        syntax = true,
        theme = "dark",
        update_on_change = true,
        throttle_at = 200000,
        -- throttle_time = "auto",
    })
end

return config
