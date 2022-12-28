return {
    {
        "j-hui/fidget.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "UIEnter",
        config = true,
    },
    { "MunifTanjim/nui.nvim" },
    {
        "kyazdani42/nvim-web-devicons",
        config = { default = true },
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
        priority = 1000,
    },
}
