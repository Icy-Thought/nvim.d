local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

lspconfig.clangd.setup({
    lsputils.init,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
})
