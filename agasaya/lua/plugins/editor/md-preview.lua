local M = {
    "toppair/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
}

function M.config()
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
        throttle_time = "auto",
    })
end

return M
