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
            cmd("ToggleTerm size=80 direction=vertical"),
            { desc = "launch vertical terminal" },
        },
        {
            "f",
            cmd("ToggleTerm direction=float"),
            { desc = "launch floating terminal" },
        },
        {
            "t",
            cmd("ToggleTerm direction=tab"),
            { desc = "launch tabbed terminal" },
        },
        {
            "p",
            cmd("lua _PYTHON_TOGGLE"),
            { desc = "launch terminal in py-env" },
        },
        {
            "<Enter>",
            cmd("ToggleTerm size=10 direction=horizontal"),
            { desc = "launch horizontal terminal" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
})
