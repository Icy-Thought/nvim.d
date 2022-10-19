local langserv = {}
local conf = require("modules.langserv.config")

langserv["saecki/crates.nvim"] = {
    event = "BufRead Cargo.toml",
    after = "nvim-lspconfig",
    config = conf.crates_nvim,
}

langserv["simrat39/rust-tools.nvim"] = {
    ft = "rust",
    config = conf.rust_tools,
}

-- langserv["simrat39/flutter-tools.nvim"] = {
--     ft = "dart",
--     after = "nvim-lspconfig",
--     config = conf.flutter_tools,
-- }

return langserv
