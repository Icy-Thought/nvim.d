local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local hint = [[
  ^ ^     פּ Visuals
  ^
  _z_: TrueZen Ataraxis
  _p_: TS Playground
  _h_: TS Highlight Capture
  ^
  ^^^^              _q_: Quit!
]]

Hydra({
    name = "Treesitter",
    hint = hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = { "n", "x" },
    body = "<Leader>z",
    heads = {
        { "z", cmd("TZAtaraxis"), { desc = "Enable True-Zen Mode" } },
        { "p", cmd("TSPlayground"), { desc = "Treesitter Playground" } },
        {
            "h",
            cmd("TSHighlightCapturesUnderCursor"),
            { desc = "TS Highlight under cursor" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
})
