local M = {
    "Vonr/align.nvim",
    event = "BufReadPost",
    config = function()
        require("keymaps.editor.align")
    end,
}

return M
