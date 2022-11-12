local config = {}

function config.haskell_tools()
    require("keymaps.langserv.haskell")

    require("haskell-tools").setup({
        tools = {
            codeLens = { autoRefresh = true },
            hoogle = { mode = "auto" },
            repl = { handler = "toggleterm" },
        },
        hls = {
            on_attach = function(client, bufnr)
                if client.name ~= "null-ls" then
                    client.server_capabilities.documentFormattingProvider =
                        false
                end
            end,
            haskell = {
                checkProject = false,
                formattingProvider = "stylish-haskell",
                plugin = {
                    refineImports = { codeLensOn = false },
                },
            },
        },
    })
end

function config.crates_nvim()
    require("crates").setup()
end

function config.rust_tools()
    require("rust-tools").setup()
    require("keymaps.langserv.rust")
end

-- function config.flutter_tools()
--     require("flutter-tools").setup()
--     require("keymaps.langserv.flutter")
-- end

return config
