local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local main_hints = [[
                     Main Hydra

  _b_: Switch Buffer                _c_: Close Buffer
  _e_: Toggle Tree                  _k_: Killall Other Buffer(s)
  _s_: Save Buffer                  _p_: Telescope Dotfiles
  _m_: Man-Pages                    _t_: Change Theme

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
        { "b", cmd("Telescope buffers"), { desc = "switch buffer" } },
        { "c", cmd("bd!"), { desc = "close active buffer" } },
        { "e", cmd("NvimTreeToggle"), { desc = "toggle Tree on working-dir" } },
        {
            "k",
            cmd("%bd|e#"),
            { desc = "close every buffer, except active buf" },
        },
        { "m", cmd("Telescope man_pages"), { desc = "open Man-Pages" } },
        { "p", cmd("Telescope dotfiles"), { desc = "open Private Config" } },
        { "t", cmd("Telescope colorscheme"), { desc = "change nvim theme" } },
        { "s", cmd("w!"), { desc = "save buffer" } },
        { "<Enter>", cmd("Dashboard"), { desc = "spawn dashboard-nvim" } },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
})
