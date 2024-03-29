local Hydra = require("hydra")

local align_hint = [[
  ^^                       Alignment                         ^
  ^
  ^^  _a_: 1 Character          _l_: Lua Pattern              ^
  ^^  _d_: 2 Character          _p_: Paragraph -> String      ^
  ^^  _w_: String               _c_: Paragraph -> 1 Character ^
  ^
  ^^                                               _q_: Quit! ^
]]

local ALS = require("align")

Hydra({
    name = "Align",
    hint = align_hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = "x",
    body = "<leader>a",
    heads = {
        {
            "a",
            function()
                ALS.align_to_char(1, true)
            end,
            { desc = "Align selected -> 1 char" },
        },
        {
            "d",
            function()
                ALS.align_to_char(2, true, true)
            end,
            { desc = "Align selected -> 2 char" },
        },
        {
            "w",
            function()
                ALS.align_to_string(false, true, true)
            end,
            { desc = "Align selected -> str" },
        },
        {
            "l",
            function()
                ALS.align_to_string(true, true, true)
            end,
            { desc = "Align selected -> Lua pattern" },
        },
        {
            "p",
            function()
                ALS.operator(
                    ALS.align_to_string,
                    { is_pattern = false, reverse = true, preview = true }
                )
            end,
            { desc = "Align selected paragraph -> str" },
        },
        {
            "c",
            function()
                ALS.operator(ALS.align_to_char, { reverse = true })
            end,
            { desc = "Left-align paragraph -> 1 char" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
