local wk = require("which-key")

local setup = {
    key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
    },
    window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 1, 1, 1, 1 },
        winblend = 0,
    },
}

wk.setup(setup)
