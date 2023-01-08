local Hydra = require("hydra")

local ht = require("haskell-tools")

local haskell_hint = [[
  ^^                  Haskell                   ^
  ^
  ^^ _b_: Buffer -> GHCi           _c_: Codelens ^
  ^^ _r_: Toggle GHCi                            ^
  ^
  ^^ _<Enter>_: Hello, Hoggle?        _q_: Quit! ^
]]

Hydra({
    name = "Haskell-Tools",
    hint = haskell_hint,
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
    body = "<leader>h",
    heads = {
        {
            "b",
            function()
                ht.repl.toggle(vim.api.nvim_buf_get_name(0))
            end,
        },
        {
            "c",
            function()
                vim.lsp.codelens.run()
            end,
            { desc = "place a microscopic-lens on your damned code" },
        },
        {
            "r",
            function()
                ht.repl.toggle()
            end,
            { desc = "toggle GHCi repl instance" },
        },
        {
            "<Enter>",
            function()
                require("haskell-tools").hoogle.hoogle_signature()
            end,
            { desc = "launch Haskell search engine" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
