local lspconfig = require("lspconfig")
local format = require("utils.format")

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

-- Override border style globally (Rounded)
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Add additional capabilities supported by nvim-cmp
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

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

local enhance_attach = function(client, bufnr)
    if client.server_capabilities.document_formatting then
        format.lsp_before_save()
    end
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Language Server Protocols
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lspconfig.sumneko_lua.setup({
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

local lsp_servers = {
    -- 'bashls',
    -- 'dockerls',
    "pyright",
    -- 'tsserver',
}

for _, server in ipairs(lsp_servers) do
    lspconfig[server].setup({
        on_attach = enhance_attach,
    })
end

lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
})

lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
})

lspconfig.hls.setup({
    capabilities = capabilities,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    settings = {
        haskell = {
            formattingProvider = "stylish-haskell",
        },
    },
})

lspconfig.texlab.setup({
    capabilities = capabilities,
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
