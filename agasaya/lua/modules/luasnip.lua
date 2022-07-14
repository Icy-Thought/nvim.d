local ls = require("luasnip")
local types = require("luasnip.util.types")

-- Load installed snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Load custom lua-snippets
require("snippets.tex")
require("snippets.tex_math")

ls.config.setup({
    delete_check_events = "TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " ", "Keyword" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "Special" } },
            },
        },
    },
    history = true,
    region_check_events = "CursorMoved",
    store_selection_keys = "<Tab>",
    updateevents = { "TextChanged", "TextChangedI", "InsertLeave" },
})

-- Keymaps required for dynamic_node(s)
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ "i", "s" }, "<C-n>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, opts)

keymap({ "i", "s" }, "<C-p>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end, opts)
