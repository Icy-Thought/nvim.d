return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        build = "CatppuccinCompile",
        opts = {
            term_colors = true,
            compile = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/catppuccin",
                suffix = "_compiled",
            },
            styles = {
                comments = { "italic" },
                functions = { "italic", "bold" },
                keywords = { "italic" },
                strings = {},
                variables = {},
            },
            integrations = {
                bufferline = true,
                gitsigns = true,
                indent_blankline = {
                    colored_indent_levels = true,
                },
                -- lightspeed = false,
                lsp_saga = true,
                lsp_trouble = true,
                neogit = true,
                notify = true,
                neotree = true,
                nvimtree = false,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.g.catppuccin_flavour = "mocha"

            if not vim.g.neovide then
                require("lualine").setup({
                    options = { theme = "catppuccin" },
                })
                vim.cmd("colorscheme catppuccin")
            end

            -- Compile Catppuccin on `PackerCompile`
            local autocmd = vim.api.nvim_create_autocmd
            autocmd("User", {
                pattern = "PackerCompileDone",
                callback = function()
                    vim.cmd("CatppuccinCompile")
                    vim.defer_fn(function()
                        vim.cmd("colorscheme catppuccin")
                    end, 0) -- Defered for live reloading
                end,
            })
        end,
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        tag = "v0.0.7",
        priority = 1000,
        opts = {
            dark_float = true,
            theme_style = "dark_default",
            transparent = false,
            comment_style = "italic",
            keyword_style = "italic",
            function_style = "italic",
            overrides = function()
                return { BufferLineBackground = {} }
            end,
        },
        config = function(_, opts)
            if vim.g.neovide then
                require("github-theme").setup(opts)
            end
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            if vim.g.neovide then
                vim.cmd("colorscheme oxocarbon")
            end
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                functions = { italic = true, bold = true },
                keywords = { italic = true },
                variables = {},
                sidebars = "dark",
                floats = "dark",
            },
            sidebars = { "qf", "help", "terminal", "packer" },
            day_brightness = 0.3,
            hide_inactive_statusline = false,
            dim_inactive = false,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)

            if not vim.g.neovide then
                require("lualine").setup({
                    options = { theme = "tokyonight" },
                })
                vim.cmd("colorscheme tokyonight")
            end
        end,
    },
}
