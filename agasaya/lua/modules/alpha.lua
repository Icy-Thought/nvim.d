local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local config_dir = vim.fn.stdpath("config")
local dasHead = vim.fn.systemlist("cat " .. config_dir .. "/dasHead.txt")
dashboard.section.header.val = dasHead

dashboard.section.buttons.val = {
    dashboard.button(
        "SPC s c",
        " Change Colorscheme",
        ":Telescope colorscheme<CR>"
    ),
    dashboard.button(
        "SPC f r",
        "  File Frecency",
        ":Telescope frecency<CR>"
    ),
    dashboard.button("SPC f f", "  Find File", ":Telescope find_files<CR>"),
    dashboard.button("SPC f n", "  New File", ":ene <BAR> startinsert<CR>"),
    dashboard.button("SPC f p", "  Find Project", ":Telescope project<CR>"),
    dashboard.button("SPC u u", "  Update Plugins", ":PackerUpdate<CR>"),
    dashboard.button("SPC q q", "  Quit", ":q<CR>"),
}

alpha.setup(dashboard.opts)
