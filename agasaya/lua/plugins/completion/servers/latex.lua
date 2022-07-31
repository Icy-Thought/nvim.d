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
                    "-X",
                    "compile",
                    "%f",
                    "--synctex",
                },
                -- onSave = true,
            },
            forwardSearch = {
                executable = "sioyek",
                -- FIXME: not working atm
                args = {
                    "--reuse-instance",
                    "--forward-search-file '%b'",
                    "--forward-search-line %n",
                    "--inverse-search",
                    "'nvim --headless -es --cmd %l:%f'",
                },
            },
            chktex = { onEdit = false, onOpenAndSave = true },
            diagnosticsDelay = 100,
            formatterLineLength = 80,
            latexFormatter = "texlab",
        },
    },
})
