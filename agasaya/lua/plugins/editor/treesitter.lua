local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "p00f/nvim-ts-rainbow",
        { "nvim-treesitter/playground", cmd = "TSPlayground" },
    },
}

function M.config()
    require("keymaps.editor.treesitter")

    local ts_conf = require("nvim-treesitter.configs")
    ts_conf.setup({
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
    })
end

return M
