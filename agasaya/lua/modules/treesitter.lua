local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = {
        "c",
        "haskell",
        "latex",
        "lua",
        "markdown",
        "norg",
        "nix",
        "python",
        "rust",
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
