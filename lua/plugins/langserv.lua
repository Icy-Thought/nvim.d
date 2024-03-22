return {
    {
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = true,
    },
    {
        "MrcJkb/haskell-tools.nvim",
        ft = "haskell",
        opts = {
            tools = {
                codeLens = { autoRefresh = true },
                hoogle = { mode = "auto" },
                hover = { disable = true },
                repl = { handler = "toggleterm" },
            },
            hls = {
                settings = {
                    haskell = {
                        checkProject = false,
                        formattingProvider = "stylish-haskell",
                        plugin = {
                            refineImports = { codeLensOn = false },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            require("haskell-tools").setup(opts)
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
