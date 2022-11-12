local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local term_hint = [[
                  Toggle-Term

  _v_: Vertical                _t_: Tabbed
  _f_: Float                   _p_: Python-Env
^
  _<Enter>_: horizontal        _q_: Quit
]]

Hydra({
    name = "ToggleTerm",
    hint = term_hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = "n",
    body = "<Leader>t",
    heads = {
        {
            "v",
            cmd("ToggleTerm direction=vertical"),
            { desc = "Launch vertical terminal" },
        },
        {
            "f",
            cmd("ToggleTerm direction=float"),
            { desc = "Launch floating terminal" },
        },
        {
            "t",
            cmd("ToggleTerm direction=tab"),
            { desc = "Launch tabbed terminal" },
        },
        {
            "p",
            cmd("lua _PYTHON_TOGGLE"),
            { desc = "Launch terminal in py-env" },
        },
        {
            "<Enter>",
            cmd("ToggleTerm direction=horizontal"),
            { desc = "Launch horizontal terminal" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
