local nls = require("null-ls")

local h = require("null-ls.helpers")
local u = require("null-ls.utils")
local s = require("null-ls.state")
local builtins = require("null-ls.builtins")

nls.setup({
    debounce = 150,
    sources = {
        -------===[ Diagnostics ]===-------
        builtins.diagnostics.markdownlint.with({
            filetypes = { "markdown" },
            command = "markdownlint-cli2",
        }),

        -------===[ Formatting ]===-------
        builtins.formatting.alejandra,
        builtins.formatting.stylua,
        builtins.formatting.stylish_haskell,
        builtins.formatting.prettier.with({
            extra_args = {
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote",
            },
        }),
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
