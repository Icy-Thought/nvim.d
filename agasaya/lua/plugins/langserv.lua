return {
    {
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = true,
    },
    {
        "MrcJkb/haskell-tools.nvim",
        ft = "haskell",
        config = function()
            require("keymaps.langserv.haskell")

            require("haskell-tools").setup({
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
            })
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
