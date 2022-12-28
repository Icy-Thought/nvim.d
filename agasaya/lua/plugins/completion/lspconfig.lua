local M = {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
}

function M.config()
    require("completion.lspconf.diagnostics")
    local lspconfig = require("lspconfig")

    -- (Init) Language-servers with our custom conf
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
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
                },
            },
        },
        texlab = {
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
        },
    }

    -- Our default LSP-Server configurations
    local handlers = require("completion.lspconf.handlers")

    local default_config = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        flags = { debounce_text_changes = 150 },
    }

    for server, config in pairs(enabled_servers) do
        config = vim.tbl_deep_extend("force", default_config, config)
        lspconfig[server].setup(config)
    end
end

return M
