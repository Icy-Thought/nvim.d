local config = {}

function config.crates_nvim()
    require("crates").setup()
end

function config.rust_tools()
    require("rust-tools").setup()
    require("keymaps.langserv.rust")
end

-- function config.flutter_tools()
--     require("flutter-tools").setup()
--     require("keymaps.langserv.flutter")
-- end

return config
