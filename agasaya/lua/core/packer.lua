local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    _G.packer_bootstrap = fn.system({
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

-- @Ae-Mc/nvim (GitHub)
function _G.prequire(plugin_name, setup)
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
        config = [[ require('impatient') ]],
    })
    use({ "wbthomason/packer.nvim" })

    -------===[ Aesthetics ]===-------
    use({ "kyazdani42/nvim-web-devicons", event = "VimEnter" })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        run = "CatppuccinCompile",
        config = [[ prequire('themes.catppuccin') ]],
    })
    -- use({
    --     "themercorp/themer.lua",
    --     config = [[ prequire('themes.themer') ]],
    -- })
    use({
        "akinsho/bufferline.nvim",
        event = "VimEnter",
        wants = "nvim-web-devicons",
        config = [[ prequire('plugins.ui.bufferline') ]],
    })
    use({
        "feline-nvim/feline.nvim",
        event = "VimEnter",
        wants = "nvim-web-devicons",
        config = [[ prequire('feline', {
	    components = require('catppuccin.groups.integrations.feline').get()
        }) ]],
    })
    use({
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        config = [[ prequire('plugins.ui.dashboard') ]],
    })
    use({
        "gelguy/wilder.nvim",
        event = "CmdlineEnter",
        requires = { "romgrk/fzy-lua-native" },
        run = "UpdateRemotePlugins",
        config = [[ prequire('plugins.ui.wilder') ]],
    })

    -------===[ Toolbox ]===-------
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            {
                "nvim-telescope/telescope-frecency.nvim",
                requires = { "tami5/sqlite.lua" },
            },
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = [[ prequire('plugins.toolbox.telescope') ]],
    })
    use({
        "kyazdani42/nvim-tree.lua",
        tag = "nightly",
        cmd = "NvimTreeToggle",
        config = [[ prequire('nvim-tree', {}) ]],
    })
    use({
        "folke/which-key.nvim",
        event = "VimEnter",
        config = [[ prequire('plugins.toolbox.which-key')
                    prequire('keymap.wk-main') ]],
    })
    use({
        "akinsho/nvim-toggleterm.lua",
        config = [[ prequire('toggleterm', {})
                    prequire('keymap.toggleterm') ]],
    })
    use({
        "TimUntersberger/neogit",
        cmd = "Neogit",
        event = "VimEnter",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('neogit', {}) ]],
    })
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        config = [[ prequire('gitsigns', {}) ]],
    })
    use({
        "windwp/nvim-spectre",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('spectre', {}) ]],
    })

    -------===[ Language Server Protocol (LSP) ]===-------
    use({
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        config = [[ prequire('plugins.completion.lspconfig') ]],
    })
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        after = "nvim-lspconfig",
        config = [[ prequire('plugins.completion.lspsaga')
                    prequire('keymap.lspsaga') ]],
    })
    use({
        "mhartington/formatter.nvim",
        event = "BufWritePre",
        config = [[ prequire('plugins.completion.formatter') ]],
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = [[ prequire('dapui', {
            floating = { border = "rounded" }
        }) ]],
    })
    use({
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        requires = { "icy-thought/friendly-snippets" },
        config = [[ prequire('plugins.completion.luasnip') ]],
    })
    use({
        "hrsh7th/nvim-cmp",
        after = { "LuaSnip" },
        requires = {
            { "saadparwaiz1/cmp_luasnip", after = { "LuaSnip", "nvim-cmp" } },
            { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },
            { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
            { "hrsh7th/cmp-path", after = "cmp-buffer" },
        },
        config = [[ prequire('plugins.completion.cmp') ]],
    })
    -- use({
    --     zbirenbaum/copilot.lua",
    --     after = "nvim-cmp",
    --     requires = {"zbirenbaum/copilot-cmp"},
    --     config = [[ prequire('copilot', {}) ]],
    -- })

    -------===[ Editor ]===-------
    use({
        "Vonr/align.nvim",
        event = "BufReadPost",
        config = [[ prequire('keymap.align') ]],
    })
    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = [[ prequire('plugins.editor.autopairs') ]],
    })
    use({
        "nvim-treesitter/nvim-treesitter",
        run = "TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = [[ prequire('plugins.editor.treesitter') ]],
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        after = "nvim-treesitter",
        config = [[ prequire('plugins.editor.blankline') ]],
    })
    use({
        "norcalli/nvim-colorizer.lua",
        event = "BufReadPost",
        config = [[ prequire('colorizer', {}) ]],
    })
    use({
        "nvim-neorg/neorg",
        ft = "norg",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('plugins.editor.neorg') ]],
    })
    use({
        "kevinhwang91/nvim-ufo",
        after = "nvim-treesitter",
        requires = { "kevinhwang91/promise-async" },
        config = [[ prequire('plugins.editor.folding') ]],
    })
    use({
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = [[ prequire('Comment', {})
                    prequire('keymap.comment ') ]],
    })
    use({
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        requires = { "nvim-lua/plenary.nvim" },
        config = [[ prequire('todo-comments', {}) ]],
    })
    use({
        "Pocco81/true-zen.nvim",
        event = "BufReadPost",
        config = [[ prequire('true-zen', {}) ]],
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        config = [[ prequire('plugins.editor.md-preview')
                    prequire('keymap.md-preview') ]],
    })

    -- Allow Packer to auto-compile nvim config
    if packer_bootstrap then
        packer.sync()
    end
end)
