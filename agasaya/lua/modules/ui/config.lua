local config = {}

function config.bufferline()
    local bufferline = require("bufferline")
    bufferline.setup({
        options = {
            numbers = "ordinal",
            diagnostics = "nvim_lsp",
            indicator = {
                icon = "▎",
                style = "icon",
            },
            buffer_close_icon = "",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            separator_style = "thin",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                        or (e == "warning" and " " or "")
                    s = s .. n .. sym
                end
                return s
            end,
        },
    })
end

function config.catppuccin()
    local catppuccin = require("catppuccin")
    catppuccin.setup({
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

    -- Our desired Catppuccin flavour:
    vim.g.catppuccin_flavour = "mocha"

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
end

function config.feline()
    require("feline").setup()
end

function config.fidget()
    require("fidget").setup()
end

function config.dashboard_nvim()
    local db = require("dashboard")
    local config_dir = vim.fn.stdpath("config")

    db.custom_header = vim.fn.systemlist("cat " .. config_dir .. "/dasHead.txt")
    db.custom_center = {
        {
            icon = "  ",
            desc = "Switch Colorscheme" .. "                    ",
            shortcut = "SPC s c",
            action = "Telescope colorscheme",
        },
        {
            icon = "  ",
            desc = "File Frecency" .. "                         ",
            shortcut = "SPC f r",
            action = "lua require('telescope').extensions.frecency.frecency()",
        },
        {
            icon = "  ",
            desc = "Find File" .. "                             ",
            shortcut = "SPC f f",
            action = "Telescope find_files",
        },
        {
            icon = "  ",
            desc = "New File" .. "                              ",
            shortcut = "SPC f n",
            action = "DashboardNewFile",
        },
        {
            icon = "  ",
            desc = "Find Project" .. "                          ",
            shortcut = "SPC f p",
            action = "Telescope project",
        },
        {
            icon = "  ",
            desc = "Browse Neovim Dotfiles" .. "                ",
            action = "Telescope dotfiles path=" .. config_dir,
            shortcut = "SPC f d",
        },
        {
            icon = "  ",
            desc = "Update Plugins" .. "                        ",
            shortcut = "SPC u u",
            action = "PackerUpdate",
        },

        {
            icon = "  ",
            desc = "Quit" .. "                                  ",
            shortcut = "SPC q q",
            action = "q",
        },
    }
end

function config.tokyo_night()
    local tokyonight = require("tokyonight")
    tokyonight.setup({
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

    if not vim.g.neovide then
        vim.cmd("colorscheme tokyonight")
    end
end

return config
