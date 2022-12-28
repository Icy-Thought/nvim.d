local M = {
    "folke/noice.nvim",
    event = "UIEnter",
}

function M.config()
    if not vim.g.neovide then
        require("noice").setup({
            hacks = { cmp_popup_row_offset = 1 },
            views = {
                mini = {
                    position = { row = "90%", col = "100%" },
                },
                cmdline_popup = {
                    position = { row = "30%", col = "50%" },
                    size = { width = "40%", height = "auto" },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        })
    end
end

return M
