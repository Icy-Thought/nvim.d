local M = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
}

function M.config()
    if not vim.g.neovide then
        local tokyonight = require("tokyonight")
        tokyonight.setup({
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = "italic",
                functions = "italic,bold",
                keywords = "italic",
                variables = "NONE",

                sidebars = "dark",
                floats = "dark",
            },
            sidebars = { "qf", "help", "terminal", "packer" },
            day_brightness = 0.3,
            hide_inactive_statusline = false,
            dim_inactive = false,
        })

        require("lualine").setup({
            options = { theme = "tokyonight" },
        })

        vim.cmd("colorscheme tokyonight")
    end
end

return M
