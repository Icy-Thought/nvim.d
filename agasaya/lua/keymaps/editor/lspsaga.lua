local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local nSaga_hint = [[
                     Lspsaga (Normal)

  _f_: LSP-Finder                  _l_: Line Diagnostic
  _a_: Code Action                 _c_: Cursor Diagnostic
  _h_: Hover-DOC                   _[_: Preview Diagnostics
  _r_: Rename Definition           _]_: Next Diagnostics
  _d_: Peek Definition             _k_: Previous Err. Diagnostic
  _o_: Outline Buffer              _j_: Next Err. Diagnostic
^
  _<Enter>_: Format Buffer                              _q_: Quit
]]

Hydra({
    name = "lspsaga-normal",
    hint = nSaga_hint,
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
    body = "<Leader>l",
    heads = {
        {
            "f",
            cmd("Lspsaga lsp_finder"),
            { desc = "Lookup code definition + reference" },
        },
        { "a", cmd("Lspsaga code_action"), { desc = "Cursor code action" } },
        { "r", cmd("Lspsaga rename"), { desc = "Rename selected definition" } },
        {
            "d",
            cmd("Lspsaga peek_definition"),
            { desc = "Peek/edit previewed definition" },
        },
        {
            "l",
            cmd("Lspsaga show_line_diagnostics"),
            { desc = "Display line diagnostics" },
        },
        {
            "c",
            cmd("Lspsaga show_cursor_diagnostics"),
            { desc = "Display cursor diagnostics" },
        },
        {
            "[",
            cmd("Lspsaga diagnostic_jump_prev"),
            { desc = "Jump to previous diagnostic" },
        },
        {
            "]",
            cmd("Lspsaga diagnostic_jump_nexr"),
            { desc = "Jump to next diagnostic" },
        },
        {
            "k",
            function()
                require("lspsaga.diagnostic").goto_prev({
                    severity = vim.diagnostic.severity.ERROR,
                })
            end,
            { desc = "Jump to previous Err. diagnostic" },
        },
        {
            "j",
            function()
                require("lspsaga.diagnostic").goto_next({
                    severity = vim.diagnostic.severity.ERROR,
                })
            end,
            { desc = "Jump to next Err. diagnostic" },
        },
        {
            "o",
            cmd("LSoutlineToggle"),
            { desc = "Outline buffer TOC" },
        },
        {
            "h",
            cmd("Lspsaga hover_doc"),
            { desc = "Floating documentation window" },
        },
        {
            "<Enter>",
            cmd("Format"),
            { exit = true, desc = "Format current buffer!" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
