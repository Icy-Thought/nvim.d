return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "BufWinEnter",
        config = {
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
    },
    {
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        config = function()
            local db = require("dashboard")
            local config_dir = vim.fn.stdpath("config")

            db.custom_header =
                vim.fn.systemlist("cat " .. config_dir .. "/dasHead.txt")
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
                    action = "Lazy update",
                },

                {
                    icon = "  ",
                    desc = "Quit" .. "                                  ",
                    shortcut = "SPC q q",
                    action = "q",
                },
            }
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "UIEnter",
        config = true,
    },
    {
        "folke/noice.nvim",
        event = "UIEnter",
        config = function()
            if not vim.g.neovide then
                require("noice").setup({
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
                })
            end
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "UIEnter",
        config = function()
            local notify = require("notify")

            notify.setup({
                background_colour = "#1A1B26",
                timeout = 1500,
            })
            vim.notify = notify
        end,
    },
    { "MunifTanjim/nui.nvim" },
    {
        "kyazdani42/nvim-web-devicons",
        config = { default = true },
    },
}
