local langserv = {}
local conf = require("modules.langserv.config")

langserv["saecki/crates.nvim"] = {
    event = "BufRead Cargo.toml",
    after = "nvim-lspconfig",
    config = conf.crates_nvim,
}

langserv["simrat39/rust-tools.nvim"] = {
    ft = "rust",
    after = "nvim-lspconfig",
    config = conf.rust_tools,
}

langserv["simrat39/rust-tools.nvim"] = {
    opt = true,
    ft = "rust",
    config = conf.rust_tools,
    requires = { { "nvim-lua/plenary.nvim", opt = false } },
}

langserv["simrat39/flutter-tools.nvim"] = {
    ft = "dart",
    after = "nvim-lspconfig",
    config = conf.flutter_tools,
}

langserv["iamcco/markdown-preview.nvim"] = {
    opt = true,
    ft = "markdown",
    run = "cd app && yarn install",
    config = conf.md_preview,
}

return langserv
