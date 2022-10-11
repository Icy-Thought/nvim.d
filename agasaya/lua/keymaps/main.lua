local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local main_hints = [[
                     Main Hydra

  _b_: Switch Buffer                _c_: Close Buffer
  _e_: Toggle Tree                  _k_: Killall Other Buffer(s)
  _s_: Save Buffer                  _p_: Telescope Dotfiles
  _m_: Man-Pages                    _t_: Change Theme
  _n_: Nix Man-Page

^
  _<Enter>_: Dashboard                   _q_: Quit
]]

Hydra({
    name = "main",
    hint = main_hints,
    config = {
        buffer = bufnr,
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = "n",
    body = "<Leader>w",
    heads = {
        { "b", cmd("Telescope buffers"), { desc = "Switch buffer" } },
        { "c", cmd("bd!"), { desc = "Close active buffer" } },
        { "e", cmd("NvimTreeToggle"), { desc = "Toggle-Tree on working dir" } },
        {
            "k",
            cmd("%bd|e#"),
            { desc = "Close every buffer, EXCEPT active buf" },
        },
        { "m", cmd("Telescope man_pages"), { desc = "Launch man-pages" } },
        { "n", cmd("Telescope manix"), { desc = "Nix docummentation search" } },
        { "p", cmd("Telescope dotfiles"), { desc = "Open private config" } },
        { "t", cmd("Telescope colorscheme"), { desc = "Change nvim theme" } },
        { "s", cmd("w!"), { desc = "Save buffer" } },
        { "<Enter>", cmd("Dashboard"), { desc = "Spawn dashboard-nvim" } },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
