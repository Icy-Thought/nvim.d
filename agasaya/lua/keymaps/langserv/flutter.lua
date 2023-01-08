local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local flutter_hint = [[
  ^^                         Flutter-Tools                                   ^
  ^
  ^^ _d_: (start) Dev-Tools Server     _e_: Display Emulators                 ^
  ^^ _r_: Reload Session               _c_: (list) Connected Devices          ^
  ^^ _R_: Restart Session              _w_: (toggle) Project Widget-Tree      ^
  ^^ _D_: De-attach Session            _l_: Restart LSP Server                ^
  ^^ _E_: End Session!                 _L_: (force) LSP -> Custom re-analysis ^
  ^
  ^^ _i_: (current) Run Project                                    _q_: Quit! ^
]]

Hydra({
    name = "Flutter-Tools",
    hint = flutter_hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            offset = 3,
            position = "middle",
        },
    },
    mode = "n",
    body = "<leader>d",
    heads = {
        { "c", cmd("FlutterDevices") },
        { "d", cmd("FlutterDevTools") },
        { "D", cmd("FlutterDetach") },
        { "e", cmd("FlutterEmulators") },
        { "E", cmd("FlutterQuit") },
        { "l", cmd("FlutterLspRestart") },
        { "L", cmd("FlutterReanalyze") },
        { "r", cmd("FlutterReload") },
        { "R", cmd("FlutterRestart") },
        { "w", cmd("FlutterOutlineToggle") },
        { "<Enter>", cmd("FlutterRun") },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
