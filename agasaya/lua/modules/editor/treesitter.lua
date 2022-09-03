-- Prefer git parsers
require("nvim-treesitter.install").prefer_git = true

-- Extra parser config
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- Configure Treesitter to our liking
require("nvim-treesitter.configs").setup({
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
    autopairs = { enable = true },
    context_commentstring = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size =
                vim.api.nvim_call_function("getfsize", { buf_name })
            return file_size > 256 * 1024
        end,
        use_languagetree = true,
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
