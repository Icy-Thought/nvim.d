local lspconfig = require("lspconfig")
local lsputils = require("utils.lsp")

-- Language Server Protocols
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local auto_lsp_setup = {
    -- 'dockerls',
    "pyright",
    -- 'tsserver',
}

for _, server in ipairs(auto_lsp_setup) do
    lspconfig[server].setup({
        lsputils.init,
    })
end

-- Import language servers defined within ./servers
function langserv(server)
    if type(server) == "string" then
        require("modules.completion.servers." .. server)
    else
        return nil
    end
end

langserv("c")
langserv("haskell")
langserv("latex")
langserv("lua")
langserv("python")
langserv("rust")
