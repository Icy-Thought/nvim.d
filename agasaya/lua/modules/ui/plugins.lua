local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { opt = false }

ui["akinsho/bufferline.nvim"] = {
    opt = true,
    tag = "*",
    event = "BufReadPost",
    config = conf.bufferline,
}

ui["glepnir/dashboard-nvim"] = {
    event = "BufWinEnter",

    config = conf.dashboard_nvim,
}

ui["j-hui/fidget.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.fidget,
}

-- ui["catppuccin/nvim"] = {
-- 	opt = false,
-- 	as = "catppuccin",
-- 	config = conf.catppuccin,
-- }

ui["folke/tokyonight.nvim"] = {
    opt = false,
    as = "catppuccin",
    config = conf.catppuccin,
}

ui["B4mbus/oxocarbon-lua.nvim"] = { opt = false }

ui["feline-nvim/feline.nvim"] = {
    opt = true,
    config = conf.feline,
}

return ui
