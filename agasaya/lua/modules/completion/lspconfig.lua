local lspconfig = require("lspconfig")

vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    virtual_text = {
        source = true,
    },
})

local signs = {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = "ﴞ ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Override border style globally (Rounded)
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Boilerplate LSP-Conf
local update_capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local enhanced_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = client.config.filetypes,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    async = true,
                })
            end,
        })
    end
end

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
    hls = {
        cmd = {
            "haskell-language-server-wrapper",
            "--lsp",
        },
    },
    nil_ls = {}, -- Nix Expression Language
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    autopep8 = { enabled = false },
                    flake8 = { enabled = false },
                    jedi_completion = { fuzzy = true, include_params = true },
                    -- https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
                    pycodestyle = { enabled = false },
                    pyflakes = { enabled = false },
                    pylint = { enabled = true, executable = "pylint" },
                    pylsp_mypy = {
                        enabled = true,
                        live_mode = false,
                        dmypy = true,
                        strict = true,
                        overrides = {
                            "--disallow-untyped-defs",
                            "--ignore-missing-imports",
                            true,
                        },
                    },
                },
            },
        },
    },
    rust_analyzer = {},
    sumneko_lua = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { disable = { "vim" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
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
    -- Our default LSP-Server configurations
    local default_config = {
        on_attach = enhanced_attach,
        capabilities = update_capabilities,
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
