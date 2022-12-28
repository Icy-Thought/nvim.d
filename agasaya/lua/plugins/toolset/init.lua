return {
    {
        "gorbit99/codewindow.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "kyazdani42/nvim-tree.lua",
        version = "nightly",
        cmd = "NvimTreeToggle",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        event = "BufReadPost",
        config = function()
            require("gitsigns").setup()
            require("keymaps.editor.gitsigns")
        end,
    },
    {
        "anuvyklack/hydra.nvim",
        event = "VimEnter",
        keys = { "<leader>" },
        config = function()
            require("keymaps.main")
            require("keymaps.options")
        end,
    },
}
