local utils = require("utils")

utils.vnoremap(
    "<leader>/",
    "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
    { desc = "Comment line" }
)
utils.vnoremap(
    "<leader>[",
    "<ESC><CMD>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>",
    { desc = "Comment selection" }
)
