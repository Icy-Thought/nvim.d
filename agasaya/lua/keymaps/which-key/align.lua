local bind = require("utils.keymap")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local def_align = {
    ["x|aa"] = map_cr("lua require('align').align_to_char(1, true)")
        :with_noremap()
        :with_desc("Align to 1 Char"),

    ["x|as"] = map_cr("lua require('align').align_to_char(2, true, true)")
        :with_noremap()
        :with_desc("Align to 2 Char"),

    ["x|aw"] = map_cr("lua require('align').align_to_string(false, true, true)")
        :with_noremap()
        :with_desc("Align to Str"),

    ["x|ar"] = map_cr("lua require('align').align_to_string(true,true,true)")
        :with_noremap()
        :with_desc("Align acc. lua pattern"),

    ["x|gaw"] = map_cr(
            "lua require('align').operator(require('align').align_to_string, { is_pattern = false, reverse = true, preview = true })"
        )
        :with_noremap()
        :with_desc("Align paragraph to Str"),

    ["x|gaa"] = map_cr(
            "lua require('align').operator(require('align').align_to_char, { reverse = true })"
        )
        :with_noremap()
        :with_desc("Align paragraph to 1 Char"),
}

bind.nvim_load_mapping(def_align)
