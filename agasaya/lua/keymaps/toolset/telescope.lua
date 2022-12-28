local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local telescope_hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _q_
]]

Hydra({
    name = "Telescope",
    hint = telescope_hint,
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
    body = "<leader>f",
    heads = {
        { "f", cmd("Telescope file_browser path=%:p:h") },
        { "g", cmd("Telescope live_grep") },
        {
            "o",
            cmd("lua require('telescope').extensions.frecency.frecency()"),
            { desc = "Recently opened files" },
        },
        { "h", cmd("Telescope help_tags"), { desc = "Vim help" } },
        { "m", cmd("MarksListBuf"), { desc = "Marks" } },
        { "k", cmd("Telescope keymaps") },
        { "O", cmd("Telescope vim_options") },
        { "r", cmd("Telescope resume") },
        { "p", cmd("Telescope project"), { desc = "Projects" } },
        {
            "/",
            cmd("Telescope current_buffer_fuzzy_find"),
            { desc = "Search in file" },
        },
        { "?", cmd("Telescope search_history"), { desc = "Search history" } },
        {
            ";",
            cmd("Telescope command_history"),
            { desc = "Command-line history" },
        },
        { "c", cmd("Telescope commands"), { desc = "Execute command" } },
        {
            "u",
            cmd("Telescope undo"),
            { desc = "Telescope version of UndoTree" },
        },
        {
            "<Enter>",
            cmd("Telescope"),
            { exit = true, desc = "List all pickers" },
        },
        { "q", nil, { exit = true, nowait = true } },
    },
})
