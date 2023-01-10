return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "glepnir/lspsaga.nvim" },
        config = function()
            require("plugins.lspconf.diagnostics")

            -- (Init) Language-servers with our custom conf
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            local lspconfig = require("lspconfig")
            local enabled_servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--suggest-missing-includes",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                    },
                },
                nil_ls = {}, -- Nix Expression Language
                pyright = {},
                rust_analyzer = {},
                sumneko_lua = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim", "packer_plugins" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                },
                                maxPreload = 100000,
                                preloadFileSize = 10000,
                            },
                            telemetry = { enable = false },
                        },
                    },
                },
                texlab = {
                    log_level = vim.lsp.protocol.MessageType.Log,
                    settings = {
                        texlab = {
                            auxDirectory = "build",
                            bibtexFormatter = "texlab",
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
                                onOpenAndSave = false,
                            },
                            diagnosticsDelay = 100,
                            formatterLineLength = 120,
                            latexFormatter = "latexindent",
                            latexindent = { modifyLineBreaks = false },
                        },
                    },
                },
            }

            -- Our default LSP-Server configurations
            local handlers = require("plugins.lspconf.handlers")

            local default_config = {
                on_attach = handlers.on_attach,
                capabilities = handlers.capabilities,
                flags = { debounce_text_changes = 150 },
            }

            for server, config in pairs(enabled_servers) do
                config = vim.tbl_deep_extend("force", default_config, config)
                lspconfig[server].setup(config)
            end
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        config = function()
            require("keymaps.editor.lspsaga")

            require("lspsaga").init_lsp_saga({
                border_style = "rounded",
                code_action_icon = " ",
                diagnostic_header = { " ", " ", " ", " " },
            })
        end,
    },
    {
        enabled = false,
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("plugins.lspconf.diagnostics")

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
                                diagnostics = {
                                    globals = { "vim", "packer_plugins" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.expand(
                                            "$VIMRUNTIME/lua/vim/lsp"
                                        )] = true,
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
                                    args = {
                                        "%f",
                                        "--synctex",
                                        "--keep-logs",
                                        "--keep-intermediates",
                                        "--outdir",
                                        "build",
                                    },
                                    executable = "tectonic",
                                    onSave = true,
                                },
                                forwardSearch = {
                                    args = {
                                        "--synctex-forward",
                                        "%l:1:%f",
                                        "%p",
                                    },
                                    executable = "zathura",
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
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufWritePre",
        config = function()
            local builtins = require("null-ls.builtins")

            require("null-ls").setup({
                debounce = 150,
                sources = {
                    -------===[ Formatting ]===-------
                    builtins.formatting.stylua,
                    builtins.formatting.nixpkgs_fmt,
                    builtins.formatting.deno_fmt,
                    builtins.formatting.black.with({
                        extra_args = { "--fast" },
                        filetypes = { "python" },
                    }),
                    builtins.formatting.isort.with({
                        extra_args = { "--profile", "black" },
                        filetypes = { "python" },
                    }),

                    -------===[ Code Action ]===-------
                    builtins.code_actions.shellcheck,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
