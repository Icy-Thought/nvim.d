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

function _G.reload_lsp()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd([[edit]])
end

function _G.open_lsp_log()
    local path = vim.lsp.get_log_path()
    vim.cmd("edit " .. path)
end

vim.cmd("command! -nargs=0 LspLog call v:lua.open_lsp_log()")
vim.cmd("command! -nargs=0 LspRestart call v:lua.reload_lsp()")

-- Boilerplate LSP-Conf
local function make_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not ok then
        return nil
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local updated_capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

    return updated_capabilities
end

local enhance_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Allow formatter.nvim to handle buf-format
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
end

-- (Init) Language-servers with our custom conf
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local server_conf = {
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

    sumneko_lua = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    disable = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
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

local lsp_servers = {
    -- No-Conf LSP
    "pyright",
    "rust_analyzer",

    -- Configured LSP-Servers
    "clangd",
    "hls",
    "sumneko_lua",
    "texlab",
}

for _, server in pairs(lsp_servers) do
    -- Our default LSP-Server configurations
    local config = {
        on_attach = enhance_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }

    if server_configs[server] ~= nil then
        config = vim.tbl_deep_extend("force", config, server_configs[server])
    end

    -- Call the setup method
    lspconfig[server].setup(config)
end
