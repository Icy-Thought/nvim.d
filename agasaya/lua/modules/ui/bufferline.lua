local bufferline = require("bufferline")

bufferline.setup({
    options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        indicator = {
            icon = "▎",
            style = "icon",
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        separator_style = "thin",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            },
        },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                    or (e == "warning" and " " or "")
                s = s .. n .. sym
            end
            return s
        end,
    },
})
