local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

lspconfig.rust_analyzer.setup({
    on_attach = lsputils.enhance_attach,
    capabilities = lsputils.capabilities,

    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
})
