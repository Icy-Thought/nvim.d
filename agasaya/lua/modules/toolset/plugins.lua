local toolset = {}
local conf = require("modules.toolset.config")

toolset["anuvyklack/hydra.nvim"] = {
    opt = true,
    keys = "<leader>",
    config = conf.hydra_nvim,
}

toolset["lewis6991/gitsigns.nvim"] = {
    opt = true,
    ft = "gitcommit",
    config = conf.gitsigns,
}

toolset["kyazdani42/nvim-tree.lua"] = {
    opt = true,
    tag = "nightly",
    cmd = "NvimTreeToggle",
    config = conf.nvim_tree,
}

toolset["TimUntersberger/neogit"] = {
    opt = true,
    cmd = "Neogit",
    event = "VimEnter",
    config = conf.neogit,
}

toolset["nvim-lua/plenary.nvim"] = { opt = false }

toolset["nvim-telescope/telescope.nvim"] = {
    opt = true,
    module = "telescope",
    cmd = "Telescope",
    config = conf.telescope,
    requires = {
        { "nvim-lua/plenary.nvim", opt = false },
        { "nvim-lua/popup.nvim", opt = true },
    },
}

toolset["nvim-telescope/telescope-file-browser.nvim"] = {
    opt = true,
    after = "telescope.nvim",
}

toolset["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope-project.nvim",
    requires = { { "kkharji/sqlite.lua", opt = true } },
}

toolset["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim",
}

toolset["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
    after = "telescope-fzf-native.nvim",
}

toolset["akinsho/toggleterm.nvim"] = {
    opt = true,
    event = "UIEnter",
    config = conf.toggleterm,
}

return toolset
