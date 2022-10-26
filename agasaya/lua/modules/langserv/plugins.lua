local langserv = {}
local conf = require("modules.langserv.config")

-- langserv["MrcJkb/haskell-tools.nvim"] = {
--     ft = "haskell",
--     config = conf.haskell_tools,
-- } TODO formatting sucks..

langserv["saecki/crates.nvim"] = {
    event = "BufRead Cargo.toml",
    config = conf.crates_nvim,
}

langserv["simrat39/rust-tools.nvim"] = {
    ft = "rust",
    config = conf.rust_tools,
}

-- langserv["simrat39/flutter-tools.nvim"] = {
--     ft = "dart",
--     config = conf.flutter_tools,
-- }

return langserv
