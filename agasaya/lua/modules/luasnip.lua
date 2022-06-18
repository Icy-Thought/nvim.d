local ls = require("luasnip")
local types = require("luasnip.util.types")

-- Load installed snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Load custom lua-snippets
require("snippets.latex")

ls.config.setup({
    enable_autosnippets = true,
    history = true,
    delete_check_events = "TextChangedI",
    region_check_events = "CursorMoved",
    updateevents = "TextChanged,TextChangedI,InsertLeave",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "Special" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "Special" } },
            },
        },
    },
})
