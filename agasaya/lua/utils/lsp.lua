local lsputils = {}

-- Add additional capabilities supported by nvim-cmp
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local enhance_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Allow formatter.nvim to handle buf-format
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
end

function lsputils.init()
    on_attach = enhance_attach
    capabilities = capabilities
end

return lsputils
