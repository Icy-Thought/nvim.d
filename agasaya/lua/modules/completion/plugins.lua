local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
    config = conf.lspconfig,
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
    opt = false,
    requires = "neovim/nvim-lspconfig",
}

completion["glepnir/lspsaga.nvim"] = {
    opt = true,
    after = "nvim-lspconfig",
    config = conf.lspsaga,
}

completion["hrsh7th/nvim-cmp"] = {
    config = conf.cmp,
    event = "InsertEnter",
    requires = {
        { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
        { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
        { "hrsh7th/cmp-cmdline", after = "cmp-path" },
        { "hrsh7th/cmp-buffer", after = "cmp-cmdline" },
    },
}

completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    config = conf.luasnip,
    requires = "Icy-Thought/friendly-snippets",
}

-- completion["zbirenbaum/copilot.lua"] = {
--     opt = true,
--     requires = "zbirenbaum/copilot-cmp",
--     config = conf.copilot,
-- }

return completion
