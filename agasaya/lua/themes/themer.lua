local themer = require("themer")

themer.setup({
    styles = {
        ["function"] = { style = "italic,bold" },
        functionBuiltIn = { style = "italic,bold" },
        parameter = { style = "italic" },
        comment = { style = "italic" },
        keyword = { style = "italic" },
        keywordBuiltIn = { style = "italic" },
        diagnostic = {
            underline = {
                error = { style = "underline" },
                hint = { style = "underline" },
                info = { style = "underline" },
                warn = { style = "underline" },
            },
            virtual_text = {
                error = { style = "italic" },
                hint = { style = "italic" },
                info = { style = "italic" },
                warn = { style = "italic" },
            },
        },
    },
})

-- TODO: enable after 0.7 branch merger
-- styles = {
--     ["function"] = { italic = true, bold = true },
--     functionbuiltin = { italic = true, bold = true },
--     comment = { italic = true },
--     keyword = { italic = true },
--     keywordBuiltIn = { italic = true },
--     diagnostic = {
--         underline = {
--             error = { underline = true },
--             warn = { underline = true },
--             info = { underline = true },
--             hint = { underline = true },
--         },
--         virtual_text = {
--             error = { italic = true },
--             warn = { italic = true },
--             info = { italic = true },
--             hint = { italic = true },
--         },
--     },
-- },
