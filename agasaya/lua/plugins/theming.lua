return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        build = "CatppuccinCompile",
        config = function()
            if not vim.g.neovide then
                require("catppuccin").setup({
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
                })

                vim.g.catppuccin_flavour = "mocha"

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
        config = function()
            if not vim.g.neovide then
                require("tokyonight").setup({
                    style = "night",
                    transparent = true,
                    terminal_colors = true,
                    styles = {
                        comments = "italic",
                        functions = "italic,bold",
                        keywords = "italic",
                        variables = "NONE",

                        sidebars = "dark",
                        floats = "dark",
                    },
                    sidebars = { "qf", "help", "terminal", "packer" },
                    day_brightness = 0.3,
                    hide_inactive_statusline = false,
                    dim_inactive = false,
                })

                require("lualine").setup({
                    options = { theme = "tokyonight" },
                })

                vim.cmd("colorscheme tokyonight")
            end
        end,
    },
}
