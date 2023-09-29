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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        opts = {
            indent = {
                char = "│",
                whitespace = {
                    highlight = { "Whitespace", "NonText" },
                    remove_blankline_trail = true,
                },
                smart_indent_cap = true,
            },
            exclude = {
                filetypes = {
                    "",
                    "NvimTree",
                    "Octo",
                    "Trouble",
                    "dashboard",
                    "git",
                    "markdown",
                    "undotree",
                },
            },
            scope = { enabled = true },
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "BufReadPost",
        config = true,
    },
    {
        "gennaro-tedesco/nvim-possession",
        dependencies = { "ibhagwan/fzf-lua" },
        opts = {
            autoload = false,
            autoswitch = {
                enable = false,
                exclude_ft = { "" },
            },
            post_hook = function()
                require("nvim-tree").toggle(false, true)
            end,
            sessions = { sessions_icon = "" },
        },
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
        "cshuaimin/ssr.nvim",
        keys = { "<leader>wr" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "HiPhish/nvim-ts-rainbow2",
            { "nvim-treesitter/playground", cmd = "TSPlayground" },
        },
        opts = {
            autopairs = { enable = true },
            context_commentstring = { enable = true },
            -- Disable TS when in larger files
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
                "latex",
                "lua",
                "markdown",
                "nix",
                "org",
                "python",
                "rust",
            },
            rainbow = function()
                local rainbow = require("ts-rainbow")
                return {
                    enable = true,
                    disable = { "jsx", "cpp" },
                    query = { "rainbow-parens" },
                    strategy = { rainbow.strategy.global },
                }
            end,
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
