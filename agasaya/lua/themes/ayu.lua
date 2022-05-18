local ayu = require("ayu")

ayu.setup({
    mirage = true,
    overrides = {},
})

local lualine = require("lualine")

lualine.setup({
    options = {
        theme = "ayu",
    },
})
