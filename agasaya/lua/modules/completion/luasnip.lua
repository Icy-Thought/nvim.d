local ls = require("luasnip")
local types = require("luasnip.util.types")

-- Load installed snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Load custom lua-snippets
local load_custom_snippets = function()
    local snippets = vim.fn.stdpath("config") .. "/snippets/*lua"
    local paths = vim.split(vim.fn.glob(snippets), "\n")

    --After saving a luasnip file reload it
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
            dofile(vim.fn.expand("%"))
            require("cmp_luasnip").clear_cache() --reload the cmp source
        end,
        pattern = paths,
    })

    for _, v in ipairs(paths) do
        dofile(v)
    end
end

-- Now we load our snippets:
load_custom_snippets()

ls.config.set_config({
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
    updateevents = "TextChanged,TextChangedI,InsertLeave",
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
