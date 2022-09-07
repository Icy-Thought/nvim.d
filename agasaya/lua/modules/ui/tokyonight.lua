require("tokyonight").setup({
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

if not vim.g.neovide then
    vim.cmd("colorscheme tokyonight")
end
