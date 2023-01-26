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
            -- Import our setup options:
            require("catppuccin").setup(opts)

            vim.g.catppuccin_flavour = "mocha"
            require("lualine").setup({
                options = { theme = "catppuccin" },
            })

            if not vim.g.neovide then
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
        "nyoom-engineering/oxocarbon.nvim",
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
            -- Import our setup options:
            require("tokyonight").setup(opts)

            require("lualine").setup({
                options = { theme = "tokyonight" },
            })

            if not vim.g.neovide then
                vim.cmd("colorscheme tokyonight")
            end
        end,
    },
}
