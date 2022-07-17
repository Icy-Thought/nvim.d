local utils = require("utils")

utils.nnoremap(
    "<leader>mp",
    "<CMD>MarkdownPreview<CR>",
    { desc = "Preview Markdown" }
)
utils.nnoremap(
    "<leader>ms",
    "<CMD>MarkdownPreviewStop<CR>",
    { desc = "Stop Markdown Preview" }
)
utils.nnoremap(
    "<leader>mt",
    "<CMD>MarkdownPreviewToggle<CR>",
    { desc = "Toggle Markdown Preview" }
)

local maps = {
    m = { name = "Markdown Preview" },
}

require("which-key").register(maps)
