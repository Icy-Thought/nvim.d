return {
    {
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = true,
    },
    {
        "MrcJkb/haskell-tools.nvim",
        version = "^3", -- Recommended
        filetypes = { "haskell", "lhaskell", "cabal", "cabalproject" },
        config = function()
            require("keymaps.langserv.haskell")
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        filetypes = "rust",
        config = function()
            require("keymaps.langserv.rust")
            require("rust-tools").setup()
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        opts = {},
    },
}
