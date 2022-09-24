local editor = {}
local conf = require("modules.editor.config")

editor["Vonr/align.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.align_nvim,
}

editor["rmagatti/auto-session"] = {
    opt = true,
    cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
    config = conf.auto_session,
}

editor["numToStr/Comment.nvim"] = {
    opt = false,
    config = conf.comment_nvim,
}

editor["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = "BufReadPost",
    config = conf.treesitter,
}

editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
    after = "nvim-treesitter",
}

editor["p00f/nvim-ts-rainbow"] = {
    opt = true,
    after = "nvim-treesitter",
}

editor["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = "BufReadPost",
    after = "nvim-treesitter",
    config = conf.blankline,
}

editor["mfussenegger/nvim-dap"] = {
    opt = true,
    cmd = {
        "DapSetLogLevel",
        "DapShowLog",
        "DapContinue",
        "DapToggleBreakpoint",
        "DapToggleRepl",
        "DapStepOver",
        "DapStepInto",
        "DapStepOut",
        "DapTerminate",
    },
    module = "dap",
    config = conf.dap,
}

editor["rcarriga/nvim-dap-ui"] = {
    opt = true,
    after = "nvim-dap",
    config = conf.dapui,
}

editor["brenoprata10/nvim-highlight-colors"] = {
    opt = true,
    event = "BufReadPost",

    config = conf.highlight_colors,
}

editor["nvim-neorg/neorg"] = {
    opt = true,
    ft = "norg",
    after = "nvim-treesitter",

    config = conf.neorg,
}

editor["kevinhwang91/nvim-ufo"] = {
    opt = true,
    after = "nvim-treesitter",
    config = conf.nvim_ufo,
}

editor["Pocco81/TrueZen.nvim"] = {
    opt = true,
    config = conf.truezen,
}

-- only for fcitx5 user who uses non-English language during coding
-- editor["brglng/vim-im-select"] = {
-- 	opt = true,
-- 	event = "BufReadPost",
-- 	config = conf.imselect,
-- }

return editor
