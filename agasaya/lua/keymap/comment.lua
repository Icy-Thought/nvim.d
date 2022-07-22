local bind = require("utils.keymap")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local def_comment = {
    ["v|<leader>/"] = map_cmd(
            "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
        )
        :with_noremap()
        :with_desc("Comment current line"),

    ["v|<leader>["] = map_cmd(
            "<ESC><CMD>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>"
        )
        :with_noremap()
        :with_desc("Comment highlighted block"),
}

bind.nvim_load_mapping(def_comment)
