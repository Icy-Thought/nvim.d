local util = require("formatter.util")

local nixpkgs_fmt = function()
    return {
        exe = "nixpkgs-fmt",
        stdin = true,
    }
end

local markdown_cli = function()
    return {
        exe = "markdownlint-cli2",
        stdin = true,
    }
end

local function prettier()
    return {
        exe = "prettier",
        args = {
            "--config-precedence",
            "prefer-file",
            "--stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            "--single-quote",
            "--no-semi",
            "--arrow-parens",
            "always",
            "--print-width",
            "100",
            "--trailing-comma",
            "all",
        },
        stdin = true,
    }
end

local stylish_hs = function()
    return {
        exe = "stylish-haskell",
        stdin = true,
    }
end

local stylua = function()
    return {
        exe = "stylua",
        args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
        },
        stdin = true,
    }
end

require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },

        -- Language specific settings:
        c = { require("formatter.filetypes.lua").clangformat },
        css = { prettier },
        haskell = { stylish_hs },
        javascript = { prettier },
        jsonc = { prettier },
        lua = { stylua },
        markdown = { markdown_cli },
        nix = { nixpkgs_fmt },
        python = {
            require("formatter.filetypes.python").black,
            require("formatter.filetypes.python").isort,
        },
        rust = { require("formatter.filetypes.rust").rustfmt },
        scss = { prettier },
        typescript = { prettier },
        yaml = { prettier },
    },
})

-- ALlow `formatter.nvim` to format buf. on-save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*" },
    command = "FormatWrite",
})
