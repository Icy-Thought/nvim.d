local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

lspconfig.texlab.setup({
    lsputils.init,
    log_level = vim.lsp.protocol.MessageType.Log,
    settings = {
        texlab = {
            auxDirectory = "build",
            build = {
                executable = "tectonic",
                args = {
                    "--keep-logs",
                    "--keep-intermediates",
                    "-synctex",
                    "-X",
                    "compile",
                    "%f",
                },
                -- onSave = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            chktex = { onEdit = false, onOpenAndSave = true },
            diagnosticsDelay = 100,
            formatterLineLength = 80,
            latexFormatter = "texlab",
        },
    },
})
