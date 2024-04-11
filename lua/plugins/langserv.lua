return {
    {
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = true,
    },
    {
        "MrcJkb/haskell-tools.nvim",
        version = "^3", -- Recommended
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        config = function()
            require("keymaps.langserv.haskell")
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            require("keymaps.langserv.rust")
            require("rust-tools").setup()
        end,
    },
    {
        "simrat39/flutter-tools.nvim",
        ft = "dart",
        config = function()
            require("flutter-tools").setup()
            require("keymaps.langserv.flutter")
        end,
    },
}
