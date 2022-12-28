local M = {
    "akinsho/toggleterm.nvim",
    event = "UIEnter",
}

function M.config()
    require("keymaps.toolset.toggleterm")

    local toggleterm = require("toggleterm")

    toggleterm.setup({
        auto_scroll = true,
        close_on_exit = true,
        start_in_insert = true,
        direction = "vertical",
        float_opts = {
            border = "curved", -- 'shadow' = ???
            winblend = 3,
        },
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
    })
end

return M
