require("catppuccin").setup({
    transparent_background = false,
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
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        bufferline = true,
        dashboard = true,
        gitgutter = false,
        gitsigns = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
        -- lightspeed = false,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        neogit = true,
        -- notify = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
        },
        which_key = true,
    },
})

-- Apply colorscheme
vim.g.catppuccin_flavour = "mocha"
vim.cmd("colorscheme catppuccin")
