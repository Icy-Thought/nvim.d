local Hydra = require("hydra")

local haskell_hint = [[
                  Haskell

  _c_: Codelens
^
  _<Enter>_: Launch Hoggle            _q_: Quit!
]]

Hydra({
    name = "Haskell-Tools",
    hint = haskell_hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = "n",
    body = "<Leader>h",
    heads = {
        {
            "c",
            function()
                vim.lsp.codelens.run()
            end,
            { desc = "codelens??" },
        },
        {
            "<Enter>",
            function()
                require("haskell-tools").hoogle.hoogle_signature()
            end,
            { desc = "Launch Haskell Search Engine" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
