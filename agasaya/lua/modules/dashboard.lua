local db = require("dashboard")
local config_dir = os.getenv("XDG_CONFIG_HOME")

db.custom_header =
    vim.fn.systemlist("cat " .. config_dir .. "/nvim/dasHead.txt")

db.custom_center = {
    -- {
    --     icon = "  ",
    --     desc = "Change Colorscheme",
    --     shortcut = "SPC s c",
    --     action = "Telescope themes",
    -- },
    {
        icon = "  ",
        desc = "File Frecency" .. "                         ",
        shortcut = "SPC f r",
        action = "Telescope frecency",
    },
    {
        icon = "  ",
        desc = "Find File" .. "                             ",
        shortcut = "SPC f f",
        action = "Telescope find_files",
    },
    {
        icon = "  ",
        desc = "New File" .. "                              ",
        shortcut = "SPC f n",
        action = "DashboardNewFile",
    },
    {
        icon = "  ",
        desc = "Find Project" .. "                          ",
        shortcut = "SPC f p",
        action = "Telescope project",
    },
    {
        icon = "  ",
        desc = "Browse Neovim Dotfiles" .. "                ",
        action = "Telescope dotfiles path=" .. config_dir .. "/nvim",
        shortcut = "SPC f d",
    },
    {
        icon = "  ",
        desc = "Update Plugins" .. "                        ",
        shortcut = "SPC u u",
        action = "PackerUpdate",
    },

    {
        icon = "  ",
        desc = "Quit" .. "                                  ",
        shortcut = "SPC q q",
        action = "q",
    },
}
