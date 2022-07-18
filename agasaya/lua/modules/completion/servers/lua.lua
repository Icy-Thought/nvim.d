local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

lspconfig.sumneko_lua.setup({
    lsputils.init,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
