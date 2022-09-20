local Hydra = require("hydra")

local option_hint = [[
  ^ ^        Options
  ^
  _a_ %{arabic} Arabic
  _c_ %{cul} cursor line
  _i_ %{list} invisible characters
  _n_ %{nu} number
  _s_ %{spell} spell
  _v_ %{ve} virtual edit
  _w_ %{wrap} wrap
  ^
       ^^^^                _q_
]]

Hydra({
    name = "Options",
    hint = option_hint, -- TODO arabic button
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
            funcs = {
                arabic = function()
                    if vim.o.arabic then
                        return "[x]"
                    else
                        return "[ ]"
                    end
                end,
            },
        },
    },
    mode = { "n", "x" },
    body = "<leader>o",
    heads = {
        {
            "a",
            function()
                if vim.o.arabic then
                    if vim.g.neovide then
                        vim.o.guifont = "VictorMono Nerd Font:h9:b"
                    end
                    vim.o.arabic = false
                else
                    if vim.g.neovide then
                        vim.o.guifont = "Scheherazade New:h9:b"
                    end
                    vim.o.arabic = true
                end
            end,
            { desc = "arabic writing environment" },
        },
        {
            "n",
            function()
                if vim.o.number then
                    vim.o.number = false
                else
                    vim.o.number = true
                end
            end,
            { desc = "number" },
        },
        {
            "v",
            function()
                if vim.o.virtualedit == "all" then
                    vim.o.virtualedit = "block"
                else
                    vim.o.virtualedit = "all"
                end
            end,
            { desc = "virtualedit" },
        },
        {
            "i",
            function()
                if vim.o.list then
                    vim.o.list = false
                else
                    vim.o.list = true
                end
            end,
            { desc = "show invisible" },
        },
        {
            "s",
            function()
                if vim.o.spell then
                    vim.o.spell = false
                else
                    vim.o.spell = true
                end
            end,
            { exit = true, desc = "spell" },
        },
        {
            "w",
            function()
                if not vim.o.wrap then
                    vim.o.wrap = true
                    -- Have `word_wrap` behave like `gq`
                    vim.keymap.set("n", "k", function()
                        return vim.v.count > 0 and "k" or "gk"
                    end, { expr = true, desc = "k or gk" })
                    vim.keymap.set("n", "j", function()
                        return vim.v.count > 0 and "j" or "gj"
                    end, { expr = true, desc = "j or gj" })
                else
                    vim.o.wrap = false
                    vim.keymap.del("n", "k")
                    vim.keymap.del("n", "j")
                end
            end,
            { desc = "wrap" },
        },
        {
            "c",
            function()
                if vim.o.cursorline == true then
                    vim.o.cursorline = false
                else
                    vim.o.cursorline = true
                end
            end,
            { desc = "cursor line" },
        },
        { "q", nil, { exit = true } },
    },
})
