local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local rust_hint = [[
                  Rust

  _r_: Runnables      _m_: Expand Macro
  _d_: Debugabbles    _c_: Open Cargo
  _s_: Rustssr        _p_: Parent Module
  _h_: Hover Actions  _w_: Reload Workspace
  _D_: Open Docs      _g_: View (Create) Graph
^
  _i_: Toggle Inlay Hints     _q_: Quit!
]]

Hydra({
    name = "Rust-Tools",
    hint = rust_hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = "n",
    body = "<Leader>r",
    heads = {
        { "r", cmd("RustRunnables") },
        { "d", cmd("RustDebuggables") },
        { "s", cmd("RustSSR") },
        { "h", cmd("RustHoverActions") },
        { "D", cmd("RustOpenExternalDocs") },
        { "m", cmd("RustExpandMacro") },
        { "c", cmd("RustOpenCargo") },
        { "p", cmd("RustParentModule") },
        { "w", cmd("RustReloadWorkspace") },
        { "g", cmd("RustViewCrateGraph") },
        { "i", cmd("RustToggleInlayHints") },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
})
