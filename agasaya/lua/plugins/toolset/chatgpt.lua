local M = {
    "jackMort/ChatGPT.nvim",
    event = "UIEnter",
}

function M.config()
    local chatgpt = require("chatgpt")
    chatgpt.setup({
        chat_window = {
            border = { text = { top = "ChatGPT-3" } },
        },
    })
end

return M
