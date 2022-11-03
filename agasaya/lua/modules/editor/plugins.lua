local editor = {}
local conf = require("modules.editor.config")

editor["Vonr/align.nvim"] = {
    event = "BufReadPost",
    config = conf.align_nvim,
}

editor["gaoDean/autolist.nvim"] = {
    ft = { "markdown", "text" },
    config = conf.autolist,
}

editor["rmagatti/auto-session"] = {
    cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
    config = conf.auto_session,
}

editor["numToStr/Comment.nvim"] = {
    event = "BufReadPost",
    config = conf.comment_nvim,
}

editor["smjonas/live-command.nvim"] = {
    event = "BufReadPost",
    config = conf.live_cmd,
}

editor["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate",
    event = "BufReadPost",
    module = "nvim-treesitter",
    config = conf.treesitter,
    requires = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
        },
        { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
        { "nvim-treesitter/playground", cmd = "TSPlayground" },
    },
}

editor["lukas-reineke/indent-blankline.nvim"] = {
    event = "BufReadPost",
    after = "nvim-treesitter",
    config = conf.blankline,
}

-- editor["mfussenegger/nvim-dap"] = {
--     module = "dap",
--     config = conf.nvim_dap,
-- }

-- editor["rcarriga/nvim-dap-ui"] = {
--     after = "nvim-dap",
--     config = conf.nvim_dapui,
-- }

editor["brenoprata10/nvim-highlight-colors"] = {
    event = "BufReadPost",
    config = conf.highlight_colors,
}

editor["nvim-neorg/neorg"] = {
    ft = "norg",
    after = "nvim-treesitter",
    config = conf.neorg,
}

editor["kevinhwang91/nvim-ufo"] = {
    event = "BufReadPost",
    after = "nvim-treesitter",
    config = conf.nvim_ufo,
    requires = { "kevinhwang91/promise-async" },
}

editor["toppair/peek.nvim"] = {
    ft = "markdown",
    run = "deno task --quiet build:fast",
    config = conf.peek_nvim,
}

editor["michaelb/sniprun"] = {
    run = "bash ./install.sh",
    config = conf.sniprun,
}

editor["Pocco81/TrueZen.nvim"] = {
    event = "BufReadPost",
    after = "nvim-treesitter",
    config = conf.truezen,
}

-- only for fcitx5 user who uses non-English language during coding
-- editor["brglng/vim-im-select"] = {
-- 	event = "BufReadPost",
-- 	config = conf.imselect,
-- }

return editor
