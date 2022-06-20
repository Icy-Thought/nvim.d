local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = {
        "bash",
        "c",
        "clojure",
        "cmake",
        "commonlisp",
        "cpp",
        "css",
        "dart",
        "dockerfile",
        "elm",
        "fennel",
        "fish",
        "gleam",
        "glsl",
        "haskell",
        "html",
        "jsonc",
        "julia",
        "kotlin",
        "ledger",
        "lua",
        "markdown",
        "nix",
        "norg",
        "perl",
        "python",
        "r",
        "rasi",
        "rust",
        "scala",
        "scheme",
        "scss",
        "toml",
        "typescript",
        "yaml",
        "zig",
    },
    sync_install = false,
    ignore_install = {},
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = {},
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
