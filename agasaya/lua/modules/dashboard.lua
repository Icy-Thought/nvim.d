vim.g.dashboard_footer_icon = "🐬 "
vim.g.dashboard_default_executive = "telescope"

local config_dir = vim.fn.stdpath("config")
local dasHead = vim.fn.systemlist("cat " .. config_dir .. "/dasHead.txt")
vim.g.dashboard_custom_header = dasHead

vim.g.dashboard_custom_section = {
    change_colorscheme = {
        description = { " Scheme change              SPC s c " },
        command = "DashboardChangeColorscheme",
    },
    find_frecency = {
        description = { " File Frecency              SPC f r " },
        command = "Telescope frecency",
    },
    find_history = {
        description = { " File History               SPC f e " },
        command = "DashboardFindHistory",
    },
    find_project = {
        description = { " Find Project               SPC f p " },
        command = "Telescope project",
    },
    find_file = {
        description = { " Find File                  SPC f f " },
        command = "DashboardFindFile",
    },
    file_new = {
        description = { " New File                   SPC f n " },
        command = "DashboardNewFile",
    },
    find_word = {
        description = { " Find word                  SPC f w " },
        command = "DashboardFindWord",
    },
}
