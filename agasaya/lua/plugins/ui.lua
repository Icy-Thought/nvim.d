return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "BufEnter",
        opts = {
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
                diagnostics_indicator = function(
                    count,
                    level,
                    diagnostics_dict,
                    context
                )
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " "
                            or (e == "warning" and " " or "")
                        s = s .. n .. sym
                    end
                    return s
                end,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
        end,
    },
    {
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        opts = function()
            local config_dir = vim.fn.stdpath("config")
            return {
                theme = "doom",
                config = {
                    header = vim.fn.systemlist(
                        "cat " .. config_dir .. "/dasHead.txt"
                    ),
                    center = {
                        {
                            action = "Telescope colorscheme",
                            desc = "Switch Colorscheme"
                                .. "                    ", -- TODO: more appropriate solution
                            icon = "  ",
                            key = "SPC s c",
                        },
                        {
                            action = "lua require('telescope').extensions.frecency.frecency()",
                            desc = "File Frecency",
                            icon = "  ",
                            key = "SPC f r",
                        },
                        {
                            action = "Telescope find_files",
                            desc = "Find File",
                            icon = "  ",
                            key = "SPC f f",
                        },
                        {
                            action = "DashboardNewFile",
                            desc = "New File",
                            icon = "  ",
                            key = "SPC f n",
                        },
                        {
                            action = "Telescope project",
                            desc = "Find Project",
                            icon = "  ",
                            key = "SPC f p",
                        },
                        {
                            action = "Telescope dotfiles path=" .. config_dir,
                            desc = "Browse Neovim Dotfiles",
                            icon = "  ",
                            key = "SPC f d",
                        },
                        {
                            action = "Lazy update",
                            desc = "Update Plugins",
                            icon = "  ",
                            key = "SPC u u",
                        },
                        {
                            action = "q",
                            desc = "Quit",
                            icon = "  ",
                            key = "SPC q q",
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            require("dashboard").setup(opts)
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "folke/noice.nvim",
        event = "UIEnter",
        opts = {
            hacks = { cmp_popup_row_offset = 1 },
            views = {
                mini = {
                    position = { row = "90%", col = "100%" },
                },
                cmdline_popup = {
                    position = { row = "30%", col = "50%" },
                    size = { width = "40%", height = "auto" },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
        config = function(_, opts)
            if not vim.g.neovide then
                require("noice").setup(opts)
            end
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "UIEnter",
        opts = {
            background_colour = "#1A1B26",
            timeout = 1000,
        },
        config = function(_, opts)
            local notify = require("notify")

            notify.setup(opts)
            vim.notify = notify
        end,
    },
    { "MunifTanjim/nui.nvim" },
    {
        "kyazdani42/nvim-web-devicons",
        opts = { default = true },
        config = function(_, opts)
            require("nvim-web-devicons").setup(opts)
        end,
    },
}
