local bind = require("utils.keymap")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local def_toggleterm = {
    ["n|<leader>tp"] = map_cr("lua _PYTHON_TOGGLE")
        :with_noremap()
        :with_desc("Python Terminal Environment"),

    ["n|<leader>tf"] = map_cr("ToggleTerm direction=float")
        :with_noremap()
        :with_desc("Floating Terminal"),

    ["n|<leader>th"] = map_cr("ToggleTerm size=10 direction=horizontal")
        :with_noremap()
        :with_desc("Horizontal Terminal"),

    ["n|<leader>tt"] = map_cr("ToggleTerm direction=tab")
        :with_noremap()
        :with_desc("Tabbed Terminal"),

    ["n|<leader>tv"] = map_cr("ToggleTerm size=80 direction=vertical")
        :with_noremap()
        :with_desc("Vertical Terminal"),
}

bind.nvim_load_mapping(def_toggleterm)

-- Define which-key category
local maps = {
    t = { name = "Terminal" },
}

require("which-key").register(maps)
