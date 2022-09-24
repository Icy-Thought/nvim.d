local config = {}

function align_nvim()
    require("keymaps.editor.align")
end

function autopairs()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    -- Initialize without config
    npairs.setup()

    -- Use built-in conditions
    local cond = require("nvim-autopairs.conds")
    npairs.add_rules({
        Rule("(", ")", { "tex", "latex" })
            :with_pair(cond.not_before_text("\\"))
            :with_pair(cond.not_before_text("@")),
    })

    npairs.add_rules({
        Rule("\\(", "\\)", { "tex", "latex" }),
    })

    npairs.add_rules({
        Rule("\\[", "\\]", { "tex", "latex" }),
    })

    npairs.add_rules({
        Rule("\\left(", "\\right)", { "tex", "latex" }):with_pair(
            cond.not_before_text("\\")
        ),
    })

    -- If you want insert `(` after select function or method item
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

function blankline()
    local blankline = require("indent_blankline")
    blankline.setup({
        char = "│",
        char_list_blankline = { "|", "┊", "┆", "¦" },
        space_char_blankline = " ",
        show_first_indent_level = true,
        show_trailing_blankline_indent = false,
        filetype_exclude = {
            "",
            "NvimTree",
            "Octo",
            "TelescopePrompt",
            "Trouble",
            "dashboard",
            "git",
            "help",
            "markdown",
            "undotree",
        },
        buftype_exclude = { "terminal", "nofile" },
        show_current_context = true,
        show_current_context_start = true,
        context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
            "type",
            "var",
            "import",
        },
    })
end

function comment_nvim()
    require("Comment").setup()
end

function highlight_colors()
    require("nvim-highlight-colors").setup()
end

function nvim_ufo()
    local ufo = require("ufo")
    ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
        end,
    })
end

function neorg()
    local neorg = require("neorg")
    neorg.setup({
        load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {
                config = {
                    markup_preset = "dimmed",
                    icon_preset = "diamond",
                },
            },
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        work = "~/Notes/Neorg/Work",
                        home = "~/Notes/Neorg/Journal",
                        GTD = "~/Notes/Neorg/GTD",
                    },
                    autochdir = true,
                    autodetect = true,
                    open_last_workspace = true,
                    default_workspace = "home",
                },
            },
            ["core.gtd.base"] = {
                config = {
                    workspace = "GTD",
                },
            },
            ["core.norg.journal"] = {
                config = {
                    workspace = "~/Notes/Neorg/Journal",
                    strategy = "nested",
                },
            },
            ["core.presenter"] = {
                config = {
                    zen_mode = "truezen",
                },
            },
            ["core.export"] = {},
            ["core.norg.qol.toc"] = {
                config = {
                    default_toc_mode = "split",
                    toc_split_placement = "left",
                    close_split_on_jump = false,
                },
            },
        },
    })
end

function treesitter()
    ts_conf = require("nvim-treesitter.configs")
    ts_conf.setup({
        autopairs = { enable = true },
        context_commentstring = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "comment",
            "cpp",
            "css",
            "fennel",
            "fish",
            "haskell",
            "latex",
            "ledger",
            "lua",
            "make",
            "markdown",
            "nix",
            "python",
            "rust",
            "vim",
        },
        highlight = { enable = true, disable = { "vim" } },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "gnn",
                scope_incremental = "gns",
                node_decremental = "gnp",
            },
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Highlight non-parentheses delimiters
            max_file_lines = 1000,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["il"] = "@loop.inner",
                    ["al"] = "@loop.outer",
                    ["icd"] = "@conditional.inner",
                    ["acd"] = "@conditional.outer",
                    ["acm"] = "@comment.outer",
                    ["ast"] = "@statement.outer",
                    ["isc"] = "@scopename.inner",
                    ["iB"] = "@block.inner",
                    ["aB"] = "@block.outer",
                    -- ["p"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["gnf"] = "@function.outer",
                    ["gnif"] = "@function.inner",
                    ["gnp"] = "@parameter.inner",
                    ["gnc"] = "@call.outer",
                    ["gnic"] = "@call.inner",
                },
                goto_next_end = {
                    ["gnF"] = "@function.outer",
                    ["gniF"] = "@function.inner",
                    ["gnP"] = "@parameter.inner",
                    ["gnC"] = "@call.outer",
                    ["gniC"] = "@call.inner",
                },
                goto_previous_start = {
                    ["gpf"] = "@function.outer",
                    ["gpif"] = "@function.inner",
                    ["gpp"] = "@parameter.inner",
                    ["gpc"] = "@call.outer",
                    ["gpic"] = "@call.inner",
                },
                goto_previous_end = {
                    ["gpF"] = "@function.outer",
                    ["gpiF"] = "@function.inner",
                    ["gpP"] = "@parameter.inner",
                    ["gpC"] = "@call.outer",
                    ["gpiC"] = "@call.inner",
                },
            },
        },
    })
end

function truezen()
    require("true-zen").setup()
end

return config
