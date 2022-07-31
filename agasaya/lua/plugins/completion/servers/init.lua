local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

-- Language Server Protocols
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lsp_noconf = {
    -- 'dockerls',
    "pyright",
    -- 'tsserver',
}

for _, server in ipairs(lsp_noconf) do
    lspconfig[server].setup({
        lsputils.init,
    })
end

-- Import language servers defined within ./servers
function _G.lsp_require(server)
    if type(server) == "string" then
        require("plugins.completion.servers." .. server)
    else
        return nil
    end
end

local languages = {
    "c",
    "haskell",
    "latex",
    "lua",
    "python",
    "rust"
}

for v in ipairs(languages) do
    lsp_require(languages[v])
end
