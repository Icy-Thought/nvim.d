local completion = {}
local conf = require("modules.completion.config")

completion["nvim-lua/plenary.nvim"] = { module = "plenary" }

completion["neovim/nvim-lspconfig"] = {
    module = "lspconfig",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = conf.lspconfig,
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = conf.null_ls,
}

completion["glepnir/lspsaga.nvim"] = {
    after = "nvim-lspconfig",
    config = conf.lspsaga,
}

completion["hrsh7th/nvim-cmp"] = {
    module = "cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = conf.nvim_cmp,
    requires = {
        { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
        { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
        { "hrsh7th/cmp-cmdline", after = "cmp-path" },
        { "hrsh7th/cmp-buffer", after = "cmp-cmdline" },
        {
            "L3MON4D3/LuaSnip",
            config = conf.luasnip,
            requires = "Icy-Thought/friendly-snippets",
        },
    },
}

completion["windwp/nvim-autopairs"] = {
    event = "InsertEnter",
    config = conf.autopairs,
}

-- completion["zbirenbaum/copilot.lua"] = {
--     after = "nvim-cmp",
--     event = "InsertEnter",
--     config = conf.copilot,
--     requires = { "zbirenbaum/copilot-cmp" }
-- }

return completion
