local M = {
    enabled = false,
    "michaelb/sniprun",
    build = "bash ./install.sh",
}

function M.config()
    local sniprun = require("sniprun")

    sniprun.setup({
        selected_interpreters = {},
        repl_enable = {},
        repl_disable = {},
        interpreter_options = {},
        display = {
            "Classic",
            "VirtualTextOk",
            "VirtualTextErr",
            "LongTempFloatingWindow",
        },
        inline_messages = 0,
        borders = "shadow",
    })
end

return M
