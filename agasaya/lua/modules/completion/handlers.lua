local M = {}

M.setup = function()
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
end

-- Boilerplate LSP-Conf
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Disable LSP formatting in favor of null-ls
-- WARNING: Make sure not to run this on **null-ls** itself!
M.on_attach = function(client, bufnr)
    local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
            async = true,
            bufnr = bufnr,
            filter = function(client)
                return client.name == "null-ls"
            end,
        })
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

return M
