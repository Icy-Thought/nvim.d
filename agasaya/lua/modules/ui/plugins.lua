local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" }

ui["akinsho/bufferline.nvim"] = {
    tag = "*",
    event = "BufWinEnter",
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

ui["nvim-lualine/lualine.nvim"] = {
    event = "UIEnter",
    -- config = conf.lualine,
}

-- ui["catppuccin/nvim"] = {
--     as = "catppuccin",
--     after = "lualine.nvim",
--     run = "CatppuccinCompile",
--     config = conf.catppuccin,
-- }

ui["folke/tokyonight.nvim"] = {
    branch = "main",
    after = "lualine.nvim",
    config = conf.tokyonight,
}

ui["decaycs/decay.nvim"] = {
    as = "decay",
    after = "lualine.nvim",
    config = conf.decay,
}

return ui
