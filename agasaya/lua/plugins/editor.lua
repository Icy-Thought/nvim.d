return {
    {
        "Vonr/align.nvim",
        event = "BufReadPost",
        config = function()
            require("keymaps.editor.align")
        end,
    },
    {
        "gaoDean/autolist.nvim",
        ft = { "markdown", "text" },
        config = true,
    },
    {
        enabled = true,
        "rmagatti/auto-session",
        cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
        opts = {
            log_level = "info",
            auto_session_enable_last_session = true,
            auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
            auto_session_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = true,
            auto_session_suppress_dirs = nil,
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        opts = {
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
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "smjonas/live-command.nvim",
        event = "BufReadPost",
        opts = {
            commands = {
                G = { cmd = "g" },
                Norm = { cmd = "norm" },
                Reg = {
                    cmd = "norm",
                    args = function(opts)
                        return (opts.count == -1 and "" or opts.count)
                            .. "@"
                            .. opts.args
                    end,
                    range = "",
                },
            },
            defaults = {
                enable_highlighting = true,
                inline_highlighting = true,
                hl_groups = {
                    insertion = "DiffAdd",
                    deletion = "DiffDelete",
                    change = "DiffChange",
                },
                debug = false,
            },
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "BufReadPost",
        config = true,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "BufReadPost",
        dependencies = { "kevinhwang91/promise-async" },
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        },
        config = function(_, opts)
            require("ufo").setup(opts)
        end,
    },
    {
        "nvim-orgmode/orgmode",
        ft = "org",
        opts = {
            org_agenda_files = { "~/Notes/Org-Mode/*" },
            org_default_notes_file = "~/Notes/Org-Mode/refile.org",
        },
        config = function(_, opts)
            require("orgmode").setup(opts)
            require("orgmode").setup_ts_grammar()
        end,
    },
    {
        enabled = false,
        "michaelb/sniprun",
        build = "bash ./install.sh",
        opts = {
            selected_interpreters = {},
            repl_enable = {},
            repl_disable = {},
            interpreter_options = {},
            display = {
                "Classic",
                "VirtualTextOk",
                "VirtualTextErr",
                "LongTempFloatingWindow",
            },
            inline_messages = 0,
            borders = "shadow",
        },
    },
    {
        "cshuaimin/ssr.nvim",
        keys = { "<leader>wr" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",

        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            { "nvim-treesitter/playground", cmd = "TSPlayground" },
        },
        opts = {
            autopairs = { enable = true },
            context_commentstring = { enable = true },
            -- Disable TS when using larger files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats =
                    pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            highlight = {
                enable = true,
                disable = { "vim" },
                additional_vim_regex_highlighting = { "org" },
            },
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
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "css",
                "dart",
                "fennel",
                "fish",
                "haskell",
                "help",
                "latex",
                "lua",
                "markdown",
                "nix",
                "org",
                "python",
                "rust",
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
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            require("keymaps.editor.treesitter")
        end,
    },
    {
        "Pocco81/TrueZen.nvim",
        event = "BufReadPost",
        config = true,
    },
}
