local M = {
    enabled = false,
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
}

function M.config()
    require("completion.lspconf.diagnostics")

    local nvim_lsp = require("lspconfig")
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")

    -- Setting up our Mason environment:
    mason.setup({
        ui = { border = "rounded" },
    })

    mason_lsp.setup({
        ensure_installed = {
            "clangd",
            "nil_ls",
            "pyright",
            "rust_analyzer",
            "sumneko_lua",
            "texlab",
        },
        automatic_installation = false,
    })

    local default_config = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        flags = { debounce_text_changes = 150 },
    }

    mason_lsp.setup_handlers({
        function(server_name)
            require("lspconfig")[server_name].setup({
                default_config,
            })
        end,

        -- (Override) Configurations:
        ["clangd"] = function()
            nvim_lsp.clangd.setup({
                default_config,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--suggest-missing-includes",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                },
            })
        end,

        ["sumneko_lua"] = function()
            nvim_lsp.sumneko_lua.setup({
                default_config,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim", "packer_plugins" } },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                        },
                        telemetry = { enable = false },
                        -- Prevent TS from overriding sumneko_lua highlighting!
                        semantic = { enable = false },
                    },
                },
            })
        end,

        ["texlab"] = function()
            nvim_lsp.texlab.setup({
                default_config,
                log_level = vim.lsp.protocol.MessageType.Log,
                settings = {
                    texlab = {
                        auxDirectory = "build",
                        build = {
                            executable = "tectonic",
                            args = {
                                "%f",
                                "--synctex",
                                "--keep-logs",
                                "--keep-intermediates",
                                "--outdir",
                                "build",
                            },
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = "zathura",
                            args = { "--synctex-forward", "%l:1:%f", "%p" },
                        },
                        chktex = {
                            onEdit = false,
                            onOpenAndSave = true,
                        },
                        diagnosticsDelay = 100,
                        formatterLineLength = 80,
                        latexFormatter = "texlab",
                    },
                },
            })
        end,
    })
end
