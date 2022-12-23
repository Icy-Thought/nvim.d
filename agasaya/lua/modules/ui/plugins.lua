local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" }

ui["MunifTanjim/nui.nvim"] = { module = "nui" }

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

ui["folke/noice.nvim"] = {
    event = "UIEnter",
    config = conf.noice,
}

ui["rcarriga/nvim-notify"] = {
    event = "UIEnter",
    module = "notify",
    config = conf.nvim_notify,
}

ui["nyoom-engineering/oxocarbon.nvim"] = {
    after = "lualine.nvim",
    config = conf.oxocarbon,
}

ui["folke/tokyonight.nvim"] = {
    after = "lualine.nvim",
    config = conf.tokyonight,
}

return ui
