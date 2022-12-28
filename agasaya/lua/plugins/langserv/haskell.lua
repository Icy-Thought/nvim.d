local M = {
    "MrcJkb/haskell-tools.nvim",
    ft = "haskell",
}

function M.config()
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
end

return M
