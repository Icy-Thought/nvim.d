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
    hls = {},
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
                    args = { "-X", "compile", "%f", "--synctex" },
                },
                forwardSearch = {
                    executable = "sioyek",
                    args = {
                        "--reuse-instance",
                        "--forward-search-file '%b'",
                        "--forward-search-line %n",
                        "--inverse-search",
                        "'nvim --headless -es --cmd %l:%f'",
                    },
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

local initialize_lsp = function()
    local handlers = require("modules.completion.handlers")

    -- Our default LSP-Server configurations
    local default_config = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }

    for server, config in pairs(enabled_servers) do
        config = vim.tbl_deep_extend("force", default_config, config)

        -- Call the setup method
        lspconfig[server].setup(config)
    end
end

initialize_lsp()

-- Call forward our LSP-Configuration
require("modules.completion.handlers").setup()
