local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local ts_hint = [[
  ^^        פּ Visuals (Treesitter)        ^
  ^
  ^^ _z_: TrueZen Ataraxis                ^
  ^^ _p_: TS Playground                   ^
  ^^ _h_: TS Highlight Capture            ^
  ^
  ^^                           _q_: Quit! ^
]]

Hydra({
    name = "Treesitter",
    hint = ts_hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = { "n", "x" },
    body = "<leader>z",
    heads = {
        { "z", cmd("TZAtaraxis"), { desc = "Enable true-zen Mode" } },
        { "p", cmd("TSPlayground"), { desc = "Treesitter playground" } },
        {
            "h",
            cmd("TSHighlightCapturesUnderCursor"),
            { desc = "TS Highlight under cursor" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
