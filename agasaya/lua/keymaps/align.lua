local ALG = require("align")
local NS = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- left-align (1 char)
keymap("x", "aa", function()
    require("align").align_to_char(1, true)
end, NS)

-- left-aligns + preview (2 char)
keymap("x", "as", function()
    require("align").align_to_char(2, true, true)
end, NS)

-- left-aligns + preview (string)
keymap("x", "aw", function()
    require("align").align_to_string(false, true, true)
end, NS)

-- left-align + preview (lua pattern)
keymap("x", "ar", function()
    require("align").align_to_string(true, true, true)
end, NS)

-- Example: gawip to align a paragraph to a string, looking left and with previews
keymap("n", "gaw", function()
    ALG.operator(
        ALG.align_to_string,
        { is_pattern = false, reverse = true, preview = true }
    )
end, NS)

-- Example gaaip to aling a paragraph to 1 character, looking left
keymap("n", "gaa", function()
    ALG.operator(ALG.align_to_char, { reverse = true })
end, NS)
