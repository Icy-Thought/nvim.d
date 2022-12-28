local M = {
    "TimUntersberger/neogit",
    event = "VimEnter",
    dependencies = {
        {
            "sindrets/diffview.nvim",
            cmd = {
                "DiffviewOpen",
                "DiffviewClose",
                "DiffviewToggleFiles",
                "DiffviewFocusFiles",
            },
        },
    },
}

function M.config()
    local neogit = require("neogit")

    neogit.setup({
        disable_signs = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        signs = {
            -- { CLOSED, OPENED }
            section = { ">", "v" },
            item = { ">", "v" },
            hunk = { "", "" },
        },
        integrations = { diffview = true },
    })
end

return M
