local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer.nvim")
    vim.cmd([[packadd packer.nvim]])
end

-- Creds: Ae-Mc/nvim (GitHub)
function prequire(plugin_name, setup)
    local ok, plugin = pcall(require, plugin_name)
    if ok then
        if type(setup) == "function" then
            setup()
        elseif type(setup) == "table" then
            plugin.setup(setup)
        elseif type(setup) == "string" then
            plugin.setup(loadstring(setup))
        end
    end
end

-- Minor Packer-UI customizations
local packer = require("packer")

packer.init({
    auto_clean = true,
    compile_on_sync = true,
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

return packer.startup(function(use)
    use({ "wbthomason/packer.nvim" })

    -- Speed up Neovim cold-start
    use({
        "lewis6991/impatient.nvim",
        config = [[ require'impatient'.enable_profile() ]],
    })

    -- Aesthetics
    -- use({
    --     "themercorp/themer.lua",
    --     config = [[ prequire('themes.themer') ]],
    -- })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = [[ prequire('themes.catppuccin') ]],
    })
    use({
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = [[ prequire('modules.alpha') ]],
    })
    use({
        "norcalli/nvim-colorizer.lua",
        config = [[ prequire('colorizer', {}) ]],
    })
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('gitsigns', {}) ]],
    })
    use({ "kyazdani42/nvim-web-devicons" })
    use({
        "feline-nvim/feline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = [[ prequire('feline', {}) ]],
    })
    use({
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = [[ prequire('modules.bufferline') ]],
    })
    use({
        "gelguy/wilder.nvim",
        run = ":UpdateRemotePlugins",
        requires = { "romgrk/fzy-lua-native" },
        config = [[ prequire('modules.wilder') ]],
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = [[ prequire('modules.blankline') ]],
    })

    -- Toolbox
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
                after = "telescope.nvim",
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                after = "telescope.nvim",
                requires = { "tami5/sqlite.lua" },
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                after = "telescope.nvim",
            },
            {
                "nvim-telescope/telescope-project.nvim",
                after = "telescope.nvim",
            },
        },
        config = [[ prequire('modules.telescope') ]],
    })
    use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
        tag = "nightly",
        config = [[ prequire('nvim-tree', {}) ]],
    })
    use({
        "folke/which-key.nvim",
        config = [[ prequire('modules.which-key')
                    prequire('keymaps.which-key') ]],
    })
    use({
        "akinsho/nvim-toggleterm.lua",
        config = [[ prequire('toggleterm', {}) ]],
    })
    use({
        "TimUntersberger/neogit",
        config = [[ prequire('neogit', {}) ]],
    })
    use({
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = [[ prequire('octo', {}) ]],
    })
    use({
        "windwp/nvim-spectre",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('spectre', {}) ]],
    })

    -- Language Server Protocol (LSP)
    -- use({
    --     zbirenbaum/copilot.lua",
    --     after = "nvim-cmp",
    --     event = "InsertEnter",
    --     requires = {"zbirenbaum/copilot-cmp"},
    --     config = [[ prequire('copilot', {}) ]],
    -- })
    use({
        "neovim/nvim-lspconfig",
        config = [[ prequire('modules.lspconfig') ]],
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('modules.null-ls') ]],
    })
    use({
        "folke/trouble.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = [[ prequire('trouble', {}) ]],
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = [[ prequire('dapui', { floating = { border = "rounded" } }) ]],
    })
    use({
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        requires = {
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
        },
        config = [[ prequire('modules.cmp') ]],
    })
    use({
        "L3MON4D3/LuaSnip",
        requires = {
            "hrsh7th/nvim-cmp",
            { "rafamadriz/friendly-snippets", after = "LuaSnip" },
        },
        config = [[ prequire('modules.luasnip') ]],
    })

    -- Editor
    use({
        "nvim-neorg/neorg",
        ft = "norg",
        after = "nvim-treesitter",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('modules.neorg') ]],
    })
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = [[ prequire('modules.treesitter') ]],
    })
    -- use({
    --     "Pocco81/AutoSave.nvim",
    --     config = [[ prequire('autosave', {}) ]],
    -- })
    use({
        "kevinhwang91/nvim-ufo",
        requires = { "kevinhwang91/promise-async" },
        config = [[ prequire('modules.folding') ]],
    })
    use({
        "numToStr/Comment.nvim",
        config = [[ prequire('Comment', {}) ]],
    })
    use({
        "windwp/nvim-autopairs",
        requires = { "hrsh7th/nvim-cmp" },
        config = [[ prequire('modules.autopairs') ]],
    })
    use({
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('todo-comments', {}) ]],
    })
    use({
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = [[ prequire('modules.md-preview') ]],
    })
    use({
        "lervag/vimtex",
        ft = "tex",
        config = [[ prequire('modules.vimtex') ]],
    })
    use({
        "Pocco81/TrueZen.nvim",
        config = [[ prequire('true-zen', {}) ]],
    })

    -- Allow Packer to auto-compile nvim config
    if packer_bootstrap then
        packer.sync()
    end
end)
