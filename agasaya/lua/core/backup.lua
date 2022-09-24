-- Required if packer == `opt`
vim.cmd([[packadd packer.nvim]])

-- Minor Packer-UI customizations
local packer = require("packer")

packer.init({
    auto_clean = true,
    auto_reload_compiled = true,
    git = { clone_timeout = 5000 },
    display = {
        working_sym = "ﲊ",
        error_sym = "✗",
        done_sym = "﫟",
        removed_sym = "",
        moved_sym = "",
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Compile packer after saving
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PackerCompileOnSave", {}),
    pattern = "packer.lua",
    callback = function(args)
        vim.cmd(string.format("source %s | PackerCompile", args.file))
    end,
})

return packer.startup(function(use)
    -------===[ Core ]===-------
    use({
        "lewis6991/impatient.nvim",
        config = [[ require('impatient') ]],
    })
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    -------===[ Aesthetics ]===-------
    use({
        "kyazdani42/nvim-web-devicons",
        module = "nvim-web-devicons",
    })

    use({
        "folke/tokyonight.nvim",
        branch = "main",
        config = initPlug("modules.ui.tokyonight"),
    })
    use("B4mbus/oxocarbon-lua.nvim")
    -- use({ "shaunsingh/oxocarbon.nvim", run = "./install.sh" })
    -- use({
    --     "catppuccin/nvim",
    --     as = "catppuccin",
    --     run = "CatppuccinCompile",
    --     config = initPlug('modules.ui.catppuccin'),
    -- })
    use({
        "akinsho/bufferline.nvim",
        event = "VimEnter",
        config = initPlug("modules.ui.bufferline"),
    })
    use({
        "feline-nvim/feline.nvim",
        event = "VimEnter",
        config = initPlug("feline", {}),
    })
    use({
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        config = initPlug("modules.ui.dashboard"),
    })

    -------===[ Toolbox ]===-------
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            {
                "nvim-telescope/telescope-frecency.nvim",
                requires = { "tami5/sqlite.lua" },
            },
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = {
            initPlug("modules.toolbox.telescope"),
            initPlug("keymaps.toolbox.telescope"),
        },
    })
    use({
        "kyazdani42/nvim-tree.lua",
        tag = "nightly",
        cmd = "NvimTreeToggle",
        config = initPlug("nvim-tree", {}),
    })
    use({
        "anuvyklack/hydra.nvim",
        event = "VimEnter",
        keys = "<space>",
        config = {
            initPlug("keymaps.main"),
            initPlug("keymaps.options"),
        },
    })
    use({
        "akinsho/nvim-toggleterm.lua",
        config = {
            initPlug("toggleterm", {}),
            initPlug("keymaps.toolbox.toggleterm"),
        },
    })
    use({
        "TimUntersberger/neogit",
        cmd = "Neogit",
        event = "VimEnter",
        config = initPlug("neogit", {}),
    })
    use({
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        event = "BufReadPost",
        config = {
            initPlug("gitsigns", {}),
            initPlug("keymaps.editor.gitsigns"),
        },
    })

    -------===[ Editor ]===-------
    use({
        "nvim-treesitter/nvim-treesitter",
        run = "TSUpdate",
        module = "nvim-treesitter",
        event = "BufReadPost",
        requires = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                after = "nvim-treesitter",
            },
            { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
            { "nvim-treesitter/playground", cmd = "TSPlayground" },
        },
        config = {
            initPlug("modules.editor.treesitter"),
            initPlug("keymaps.editor.treesitter"),
        },
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        after = "nvim-treesitter",
        config = initPlug("modules.editor.blankline"),
    })
    use({
        "levouh/tint.nvim",
        after = "nvim-treesitter",
        config = initPlug("tint", {}),
    })
    use({
        "Vonr/align.nvim",
        event = "BufReadPost",
        config = initPlug("keymaps.editor.align"),
    })
    use({
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = initPlug("Comment", {}),
    })
    use({
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = initPlug("modules.editor.autopairs"),
    })
    use({
        "brenoprata10/nvim-highlight-colors",
        opt = true,
        event = "BufReadPost",
        config = initPlug("nvim-highlight-colors", {}),
    })
    use({
        "nvim-neorg/neorg",
        ft = "norg",
        after = "nvim-treesitter",
        config = initPlug("modules.editor.neorg"),
    })
    use({
        "kevinhwang91/nvim-ufo",
        after = "nvim-treesitter",
        requires = { "kevinhwang91/promise-async" },
        config = initPlug("modules.editor.folding"),
    })
    use({
        "Pocco81/TrueZen.nvim",
        event = "BufReadPost",
        config = initPlug("true-zen", {}),
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        config = {
            initPlug("modules.editor.md-preview"),
            initPlug("keymaps.editor.md-preview"),
        },
    })

    -------===[ Language Server Protocol (LSP) ]===-------
    use({
        "neovim/nvim-lspconfig",
        module = "lspconfig",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = initPlug("modules.completion.lspconfig"),
    })
    use({
        "j-hui/fidget.nvim",
        after = "nvim-lspconfig",
        config = initPlug("fidget", {}),
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        config = initPlug("modules.completion.null-ls"),
    })
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        after = "nvim-lspconfig",
        config = {
            initPlug("modules.completion.lspsaga"),
            initPlug("keymaps.editor.lspsaga"),
        },
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = initPlug("dapui", {
            floating = { border = "rounded" },
        }),
    })
    use({
        "hrsh7th/nvim-cmp",
        wants = "LuaSnip",
        event = { "InsertEnter", "CmdlineEnter" },
        requires = {
            { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
            { "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
            { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
            { "hrsh7th/cmp-buffer", after = "cmp-path" },
            { "hrsh7th/cmp-cmdline", after = "cmp-path" },
            {
                "L3MON4D3/LuaSnip",
                event = { "InsertEnter", "CmdlineEnter" },
                wants = "friendly-snippets",
                requires = { "Icy-Thought/friendly-snippets" },
                config = initPlug("modules.completion.luasnip"),
            },
        },
        config = initPlug("modules.completion.cmp"),
    })
    -- use({
    --     zbirenbaum/copilot.lua",
    --     after = "nvim-cmp",
    --     requires = {"zbirenbaum/copilot-cmp"},
    --     config = initPlug('copilot', {}),
    -- })

    -------===[ Language Specific Configurations ]===-------
    use({
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        after = "nvim-lspconfig",
        config = initPlug("crates", {}),
    })
    use({
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = {
            initPlug("rust-tools", {}),
            initPlug("keymaps.editor.rust-tools"),
        },
    })
    -- use({
    --     "simrat39/flutter-tools.nvim",
    --     ft = "dart",
    --     config = initPlug('flutter-tools', {}),
    -- })

    -- Allow Packer to auto-compile nvim config
    if packer_bootstrap then
        packer.sync()
    end
end)
