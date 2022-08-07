local lsputils = {}

-- Add additional capabilities supported by nvim-cmp
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

function lsputils.init()
    on_attach = enhance_attach()
    capabilities = make_capabilities()
end

return lsputils
