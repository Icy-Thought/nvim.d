local M = {
    "glepnir/lspsaga.nvim",
    config = function()
        require("keymaps.editor.lspsaga")
    end,
}

function M.config()
    local saga = require("lspsaga")

    saga.init_lsp_saga({
        border_style = "rounded",
        code_action_icon = " ",
        diagnostic_header = { " ", " ", " ", " " },
    })
end

return M
