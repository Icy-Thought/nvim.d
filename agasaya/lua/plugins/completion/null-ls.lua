local M = { "jose-elias-alvarez/null-ls.nvim" }

function M.setup()
    local nls = require("null-ls")
    local builtins = require("null-ls.builtins")

    nls.setup({
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
end

return M
