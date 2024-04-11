local M = {}

-- Boilerplate LSP-Conf
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Disable LSP formatting in favor of null-ls
-- WARNING: Make sure not to run this on **null-ls** itself!
M.on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    async = false,
                    bufnr = bufnr,
                })
            end,
        })
    end
end

return M
