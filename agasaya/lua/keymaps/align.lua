local ALG = require("align")
local utils = require("utils")

-- left-align (1 char)
utils.xnoremap("aa", function()
    ALG.align_to_char(1, true)
end, { desc = "Align to 1 Char" })

-- left-aligns + preview (2 char)
utils.xnoremap("as", function()
    ALG.align_to_char(2, true, true)
end, { desc = "Align to 2 Char" })

-- left-aligns + preview (string)
utils.xnoremap("aw", function()
    ALG.align_to_string(false, true, true)
end, { desc = "Align to Str" })

-- left-align + preview (lua pattern)
utils.xnoremap("ar", function()
    ALG.align_to_string(true, true, true)
end, { desc = "Align to Lua pattern" })

-- Example: gawip to align a paragraph to a string, looking left and with previews
utils.nnoremap("gaw", function()
    ALG.operator(
        ALG.align_to_string,
        { is_pattern = false, reverse = true, preview = true }
    )
end, { desc = "Align paragraph to Str" })

-- Example gaaip to aling a paragraph to 1 character, looking left
utils.nnoremap("gaa", function()
    ALG.operator(ALG.align_to_char, { reverse = true })
end, { desc = "Align paragraph to 1 Char" })
