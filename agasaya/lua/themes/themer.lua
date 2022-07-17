require("themer").setup({
    styles = {
        ["function"] = { italic = true, bold = true },
        functionbuiltin = { italic = true, bold = true },
        comment = { italic = true },
        keyword = { italic = true },
        keywordBuiltIn = { italic = true },
        diagnostic = {
            underline = {
                error = { underline = true },
                warn = { underline = true },
                info = { underline = true },
                hint = { underline = true },
            },
            virtual_text = {
                error = { italic = true },
                warn = { italic = true },
                info = { italic = true },
                hint = { italic = true },
            },
        },
    },
})

require("telescope").load_extension("themes")
