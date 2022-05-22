local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(clients)
            -- filter out clients that you don't want to use
            return vim.tbl_filter(function(client)
                return client.name ~= "tsserver"
            end, clients)
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
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

local null_ls = prequire("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debounce = 150,
    sources = {
        formatting.alejandra,
        formatting.stylua,
        formatting.prettier.with({
            extra_args = {
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote",
            },
        }),
        formatting.black.with({
            extra_args = { "--fast" },
            filetypes = { "python" },
        }),
        formatting.isort.with({
            extra_args = { "--profile", "black" },
            filetypes = { "python" },
        }),
        diagnostics.ansiblelint.with({
            condition = function(utils)
                return utils.root_has_file("roles")
                    and utils.root_has_file("inventories")
            end,
        }),
        diagnostics.shellcheck,
        diagnostics.markdownlint.with({
            filetypes = { "markdown" },
            command = "markdownlint-cli2",
        }),
        diagnostics.vale.with({
            filetypes = { "markdown" },
        }),
        diagnostics.revive.with({
            condition = function(utils)
                return utils.root_has_file("revive.toml")
            end,
        }),
        code_actions.shellcheck,
    },
    on_attach = on_attach,
})
