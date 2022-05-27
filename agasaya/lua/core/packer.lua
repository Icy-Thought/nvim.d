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
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    use({ "wbthomason/packer.nvim" })

    -- Colorschemes
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        opt = false,
        config = [[ prequire('themes.catppuccin') ]],
    })

    use({
        "Shatur/neovim-ayu",
        as = "ayu",
        opt = true,
        config = [[ prequire('themes.ayu') ]],
    })
    use({
        "olimorris/onedarkpro.nvim",
        as = "onedark-pro",
        opt = true,
        config = [[ prequire('themes.onedark-pro') ]],
    })
    use({
        "rose-pine/neovim",
        as = "rose-pine",
        opt = true,
        config = [[ prequire('themes.rose-pine') ]],
    })

    -- Aesthetics
    -- use({
    --     "ChristianChiarulli/dashboard-nvim",
    --     config = [[ prequire('modules.dashboard') ]],
    -- })
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

    use({ "kyazdani42/nvim-web-devicons" }) -- TODO: check icon status later.
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- TODO: check proper way
        config = [[ prequire('modules.lualine') ]],
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
        config = [[ prequire('modules.wilder') ]], -- TODO: add fzy-lua-native + cpsm deps.
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = [[ prequire('modules.blankline') ]],
    })

    -- Toolset
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('modules.telescope') ]],
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({
        "nvim-telescope/telescope-frecency.nvim",
        requires = {
            "tami5/sqlite.lua",
            "kyazdani42/nvim-web-devicons",
        },
    })
    use({ "nvim-telescope/telescope-project.nvim" })
    use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
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

    -- Editor
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
        "hrsh7th/nvim-cmp",
        requires = { "neovim/nvim-lspconfig" },
        config = [[ prequire('modules.cmp') ]],
    })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "L3MON4D3/LuaSnip" })
    use({ "rafamadriz/friendly-snippets" })
    use({ "saadparwaiz1/cmp_luasnip" })

    -- use {'github/copilot.vim'}
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = [[ prequire('modules.treesitter') ]],
    })
    use({
        "numToStr/Comment.nvim",
        config = [[ prequire('Comment', {}) ]],
    })
    use({
        "windwp/nvim-autopairs",
        config = [[ prequire('nvim-autopairs', {}) ]],
    })
    use({
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('todo-comments', {}) ]],
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = [[ prequire('modules.md-preview') ]],
    })
    use({
        "lervag/vimtex",
        config = [[ prequire('modules.vimtex') ]],
    })
    use({
        "iurimateus/luasnip-latex-snippets.nvim",
        requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
        ft = "tex",
    })

    -- Allow Packer to auto-compile nvim config
    if packer_bootstrap then
        packer.sync()
    end
end)
