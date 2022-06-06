local neorg = require("neorg")

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.concealer"] = {
            config = {
                markup_preset = "dimmed",
                icon_preset = "diamond",
                dim_code_blocks = true,
            },
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/Notes/Neorg/Work",
                    home = "~/Notes/Neorg/Journal",
                },
                autochdir = true,
                autodetect = true,
                open_last_workspace = true,
                index = "index.norg",
            },
        },
        ["core.gtd.base"] = {
            config = {
                workspace = "~/Notes/Neorg/GTD",
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
            },
        },
        ["core.norg.journal"] = {
            config = {
                workspace = "~/Notes/Neorg/Journal",
                strategy = "nested",
            },
        },
        ["core.presenter"] = {},
        ["core.norg.qol.toc"] = {
            config = {
                default_toc_mode = "split",
                toc_split_placement = "left",
                close_split_on_jump = false,
            },
        },
    },
})
