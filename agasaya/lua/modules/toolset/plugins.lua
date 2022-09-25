local toolset = {}
local conf = require("modules.toolset.config")

toolset["anuvyklack/hydra.nvim"] = {
    module = "hydra",
    keys = "<leader>",
    event = "VimEnter",
    config = conf.hydra_nvim,
}

toolset["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    event = "BufReadPost",
    config = conf.gitsigns,
}

toolset["kyazdani42/nvim-tree.lua"] = {
    tag = "nightly",
    cmd = "NvimTreeToggle",
    event = "BufReadPost",
    config = conf.nvim_tree,
}

-- toolset["TimUntersberger/neogit"] = {
--     cmd = "Neogit",
--     event = "VimEnter",
--     config = conf.neogit,
--     requires = {
--         {
--             "sindrets/diffview.nvim",
--             cmd = {
--                 "DiffviewOpen",
--                 "DiffviewClose",
--                 "DiffviewToggleFiles",
--                 "DiffviewFocusFiles",
--             },
--         },
--     },
-- }

toolset["nvim-telescope/telescope.nvim"] = {
    module = "telescope",
    cmd = "Telescope",
    config = conf.telescope,
    requires = {
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        {
            "nvim-telescope/telescope-frecency.nvim",
            requires = { "tami5/sqlite.lua" },
        },
        "nvim-telescope/telescope-project.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
}

toolset["akinsho/toggleterm.nvim"] = {
    event = "UIEnter",
    config = conf.toggleterm,
}

return toolset
