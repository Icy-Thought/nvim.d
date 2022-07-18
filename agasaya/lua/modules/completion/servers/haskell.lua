local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

lspconfig.hls.setup({
    lsputils.init,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    settings = {
        haskell = {
            formattingProvider = "stylish-haskell",
        },
    },
})
