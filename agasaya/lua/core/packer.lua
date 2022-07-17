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
            plugin.setup(load(setup))
        end
    end
end

-- Minor Packer-UI customizations
local packer = require("packer")

packer.init({
    auto_clean = true,
    auto_reload_compiled = true,
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
    -------===[ Core ]===-------
    use({
        "lewis6991/impatient.nvim",
        config = [[ require'impatient'.enable_profile() ]],
    })
    use({ "wbthomason/packer.nvim" })
    use({ "nvim-lua/plenary.nvim", event = "BufRead" })

    -------===[ Aesthetics ]===-------
    use({ "kyazdani42/nvim-web-devicons", event = "VimEnter" })
    use({
        "akinsho/bufferline.nvim",
        after = "nvim-web-devicons",
        config = [[ prequire('modules.bufferline') ]],
    })
    -- use({
    --     "themercorp/themer.lua",
    --     config = [[ prequire('themes.themer') ]],
    -- })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        run = "CatppuccinCompile",
        after = "bufferline.nvim",
        config = [[ prequire('themes.catppuccin') ]],
    })
    use({
        "feline-nvim/feline.nvim",
        after = "catppuccin",
        config = [[ prequire('feline', {
	    components = require('catppuccin.groups.integrations.feline').get()
        }) ]],
    })
    use({
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        after = "catppuccin",
        config = [[ prequire('modules.dashboard') ]],
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
    use({
        "norcalli/nvim-colorizer.lua",
        after = "catppuccin",
        config = [[ prequire('colorizer', {}) ]],
    })
    use({
        "lewis6991/gitsigns.nvim",
        after = "plenary.nvim",
        config = [[ prequire('gitsigns', {}) ]],
    })

    -------===[ Toolbox ]===-------
    use({
        "nvim-telescope/telescope.nvim",
        after = "nvim-web-devicons",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            {
                "nvim-telescope/telescope-frecency.nvim",
                requires = { "tami5/sqlite.lua" },
            },
            "nvim-telescope/telescope-project.nvim",
        },
        config = [[ prequire('modules.telescope') ]],
    })
    use({
        "kyazdani42/nvim-tree.lua",
        tag = "nightly",
        cmd = "NvimTreeToggle",
        config = [[ prequire('nvim-tree', {}) ]],
    })
    use({
        "folke/which-key.nvim",
        config = [[ prequire('modules.which-key')
                    prequire('keymaps.wk-main') ]],
    })
    use({
        "akinsho/nvim-toggleterm.lua",
        config = [[ prequire('toggleterm', {})
                    prequire('keymaps.toggleterm') ]],
    })
    use({
        "TimUntersberger/neogit",
        after = "dashboard-nvim",
        cmd = "Neogit",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('neogit', {}) ]],
    })
    use({
        "pwntester/octo.nvim",
        after = "telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('octo', {}) ]],
    })
    use({
        "windwp/nvim-spectre",
        after = "plenary.nvim",
        config = [[ prequire('spectre', {}) ]],
    })

    -------===[ Language Server Protocol (LSP) ]===-------
    use({
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        config = [[ prequire('modules.lspconfig') ]],
    })
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        after = "nvim-lspconfig",
        config = [[ prequire('modules.lspsaga') 
                    prequire('keymaps.lspsaga') ]],
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = [[ prequire('dapui', { 
            floating = { border = "rounded" } 
        }) ]],
    })
    use({
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        requires = {
            { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
            { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },
            { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
            { "hrsh7th/cmp-path", after = "cmp-buffer" },
        },
        config = [[ prequire('modules.cmp') ]],
    })
    use({
        "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        requires = { "rafamadriz/friendly-snippets" },
        config = [[ prequire('modules.luasnip') ]],
    })
    -- use({
    --     zbirenbaum/copilot.lua",
    --     after = "nvim-cmp",
    --     event = "InsertEnter",
    --     requires = {"zbirenbaum/copilot-cmp"},
    --     config = [[ prequire('copilot', {}) ]],
    -- })

    -------===[ Editor ]===-------
    use({
        "Vonr/align.nvim",
        config = [[ prequire('keymaps.align') ]],
    })
    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = [[ prequire('modules.autopairs') ]],
    })
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        event = { "BufRead", "BufNewFile" },
        requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = [[ prequire('modules.treesitter') ]],
    })
    use({
        "nvim-neorg/neorg",
        ft = "norg",
        after = "nvim-treesitter",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('modules.neorg') ]],
    })
    use({
        "kevinhwang91/nvim-ufo",
        requires = { "kevinhwang91/promise-async" },
        config = [[ prequire('modules.folding') ]],
    })
    use({
        "numToStr/Comment.nvim",
        after = "nvim-treesitter",
        config = [[ prequire('Comment', {})
                    prequire('keymaps.comment ') ]],
    })
    use({
        "folke/todo-comments.nvim",
        after = "nvim-treesitter",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('todo-comments', {}) ]],
    })
    use({
        "Pocco81/TrueZen.nvim",
        after = "nvim-treesitter",
        config = [[ prequire('true-zen', {}) ]],
    })
    use({
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = [[ prequire('modules.md-preview') ]],
    })

    -- Allow Packer to auto-compile nvim config
    if packer_bootstrap then
        packer.sync()
    end
end)
