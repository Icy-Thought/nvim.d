local bind = require("utils.keymap")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local def_mdpreview = {
    ["n|<leader>mp"] = map_cr("MarkdownPreview")
        :with_nnoremap()
        :with_desc("Preview Markdown File"),

    ["n|<leader>ms"] = map_cr("MarkdownPreviewStop")
        :with_nnoremap()
        :with_desc("Stop Markdown Preview"),

    ["n|<leader>mt"] = map_cr("MarkdownPreviewToggle")
        :with_nnoremap()
        :with_desc("Toggle Markdown Preview"),
}

bind.nvim_load_mapping(def_mdpreview)

-- Define which-key category
local maps = {
    m = { name = "Markdown Preview" },
}

require("which-key").register(maps)
