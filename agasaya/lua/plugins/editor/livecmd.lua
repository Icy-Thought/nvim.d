local M = {
    "smjonas/live-command.nvim",
    event = "BufReadPost",
}

function M.config()
    local livecmd = require("live-command")

    livecmd.setup({
        commands = {
            G = { cmd = "g" },
            Norm = { cmd = "norm" },
            Reg = {
                cmd = "norm",
                args = function(opts)
                    return (opts.count == -1 and "" or opts.count)
                        .. "@"
                        .. opts.args
                end,
                range = "",
            },
        },
        defaults = {
            enable_highlighting = true,
            inline_highlighting = true,
            hl_groups = {
                insertion = "DiffAdd",
                deletion = "DiffDelete",
                change = "DiffChange",
            },
            debug = false,
        },
    })
end

return M
