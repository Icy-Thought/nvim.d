local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" }

ui["akinsho/bufferline.nvim"] = {
    tag = "*",
    event = "BufReadPost",
    config = conf.bufferline,
}

ui["glepnir/dashboard-nvim"] = {
    event = "BufWinEnter",
    config = conf.dashboard_nvim,
}

ui["j-hui/fidget.nvim"] = {
    event = "BufReadPost",
    config = conf.fidget,
}

-- ui["catppuccin/nvim"] = {
--     as = "catppuccin",
--     run = "CatppuccinCompile",
--     config = conf.catppuccin,
-- }

ui["folke/tokyonight.nvim"] = {
    branch = "main",
    config = conf.tokyo_night,
}

ui["B4mbus/oxocarbon-lua.nvim"] = {
    opt = false,
    -- config = conf.oxocarbon,
}

ui["feline-nvim/feline.nvim"] = {
    event = "VimEnter",
    config = conf.feline,
}

return ui
