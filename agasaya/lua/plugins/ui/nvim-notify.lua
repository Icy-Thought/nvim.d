local M = {
    "rcarriga/nvim-notify",
    event = "UIEnter",
}

function M.config()
    local notify = require("notify")

    notify.setup({
        background_colour = "#1A1B26",
        timeout = 1500,
    })
    vim.notify = notify
end

return M
