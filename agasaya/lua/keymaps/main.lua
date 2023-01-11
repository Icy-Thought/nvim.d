local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local normal_hints = [[
  ^^                        Main Hydra                             ^
  ^
  ^^ _b_: Switch Buffer                _c_: Close Buffer            ^
  ^^ _e_: Toggle Tree                  _k_: Killall Other Buffer(s) ^
  ^^ _p_: Telescope Dotfiles           _r_: Structural Replace      ^
  ^^ _m_: Man-Pages                    _t_: Change Theme            ^
  ^^ _n_: Nix Man-Page                 _l_: Toggle CodeWindow       ^
  ^
  ^^ _<Enter>_: Dashboard                                _q_: Quit! ^
]]

Hydra({
    name = "main-normal",
    hint = normal_hints,
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
    body = "<leader>w",
    heads = {
        { "b", cmd("Telescope buffers"), { desc = "Switch buffer" } },
        { "c", cmd("bd!"), { desc = "Close active buffer" } },
        { "e", cmd("Neotree toggle"), { desc = "Toggle Tree on working dir" } },
        { "k", cmd("%bd|e#"), { desc = "Close buffers, EXCEPT active buf" } },
        {
            "l",
            function()
                local codewindow = require("codewindow")
                codewindow.toggle_minimap()
                codewindow.toggle_focus()
            end,
            { desc = "Open/Close code-window" },
        },
        { "m", cmd("Telescope man_pages"), { desc = "Launch man-pages" } },
        { "n", cmd("Telescope manix"), { desc = "Nix docummentation search" } },
        { "p", cmd("Telescope dotfiles"), { desc = "Open private config" } },
        { "t", cmd("Telescope colorscheme"), { desc = "Change nvim theme" } },
        {
            "r",
            function()
                require("ssr").open()
            end,
            { desc = "launch mini-buffer for editing/replacing search term." },
        },
        { "<Enter>", cmd("Dashboard"), { desc = "Spawn dashboard-nvim" } },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})

local visual_hints = [[
  ^^                     Main Hydra                ^
  ^
  ^^ _r_: Structural Replace                        ^
  ^
  ^^                                     _q_: Quit! ^
]]

Hydra({
    name = "main-visual",
    hint = visual_hints,
    config = {
        buffer = bufnr,
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = "x",
    body = "<leader>w",
    heads = {
        {
            "r",
            function()
                require("ssr").open()
            end,
            { desc = "launch mini-buffer for editing/replacing search term." },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
