require("lazy").setup("plugins", {
    change_detection = { notify = false },
    checker = { enabled = true },
    defaults = { lazy = true },
    install = {
        colorscheme = {
            "tokyonight",
            "oxocarbon",
        },
    },
    ui = { border = "rounded" },
})
