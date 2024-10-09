return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
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
                -- pylyzer = {
                --     settings = {
                --         python = {
                --             diagnostics = true,
                --             inlayHints = true,
                --             smartCompletion = true,
                --         },
                --     },
                -- },
                lua_ls = {
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
                pyright = {},
                rust_analyzer = {},
                texlab = {
                    log_level = vim.lsp.protocol.MessageType.Log,
                    settings = {
                        texlab = {
                            auxDirectory = "build",
                            bibtexFormatter = "texlab",
                            build = {
                                executable = "latexmk",
                                args = {
                                    "-pdf",
                                    "-interaction=nonstopmode",
                                    "-synctex=1",
                                    "%f",
                                    "-output-directory=../build",
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
                typst_lsp = {},
                ts_ls = {},
                biome = {},
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
        event = "BufRead",
        config = function()
            require("lspsaga").setup({
                ui = {
                    border = "rounded",
                    code_action = "󰛩 ",
                    diagnostic = " ",
                },
            })
            require("keymaps.editor.lspsaga")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = "BufReadPre",
        opts = function()
            local builtins = require("null-ls.builtins")
            return {
                debounce = 150,
                sources = {
                    -------===[ Python ]===-------
                    builtins.formatting.black.with({
                        extra_args = { "--fast" },
                        filetypes = { "python" },
                    }),
                    builtins.formatting.isort.with({
                        extra_args = { "--profile", "black" },
                        filetypes = { "python" },
                    }),

                    -------===[ General ]===-------
                    builtins.formatting.stylua,
                    builtins.formatting.nixfmt, -- Nix
                    builtins.formatting.biome,
                },
            }
        end,
    },
}
