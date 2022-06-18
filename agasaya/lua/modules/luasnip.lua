local ls = require("luasnip")
local types = require("luasnip.util.types")

-- Load installed snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Load custom lua-snippets
require("snippets.tex-main")
require("snippets.tex-math")

ls.config.setup({
    history = true,
    enable_autosnippets = true,

    region_check_events = "CursorMoved",
    delete_check_events = "TextChangedI",
    updateevents = "TextChanged,TextChangedI,InsertLeave",

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "GruvboxOrange" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "GruvboxBlue" } },
            },
        },
    },
})
