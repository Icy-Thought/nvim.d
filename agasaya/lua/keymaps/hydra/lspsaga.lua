local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local normal_hint = [[
                     Lspsaga (Normal)
  _f_: LSP-Finder                  _r_: Rename Definition
  _a_: Code Action                 _l_: Line Diagnostic
  _h_: Hover-DOC                   _j_: Preview Diagnostics
  _s_: Signature Help              _k_: Next Diagnostics
  _d_: Preview Definition          _p_: Previous Error Diagnostic
  _c_: Format Buffer               _n_: Next Error Diagnostic
^
  _<Enter>_: Format + Save Buffer                   _q_: Quit
]]

local action = require("lspsaga.codeaction")
local diagnostic = require("lspsaga.diagnostic")
local definition = require("lspsaga.definition")
local hover = require("lspsaga.hover")
local rename = require("lspsaga.rename")
local signature = require("lspsaga.signaturehelp")

Hydra({
    name = "lspsaga-normal",
    hint = normal_hint,
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
    body = "<leader>l",
    heads = {
        {
            "f",
            cmd("Lspsaga lsp_finder"),
            { desc = "Lookup code definition + reference" },
        },
        {
            "a",
            function()
                action.code_action()
            end,
            { desc = "Cursor code action" },
        },
        {
            "h",
            function()
                hover.render_hover_doc()
            end,
            { desc = "Call forward Hover-DOC" },
        },
        {
            "s",
            function()
                signature.signature_help()
            end,
            { desc = "Display signature help" },
        },
        {
            "d",
            function()
                rename.rename_lsp()
            end,
            { desc = "Rename selected definition" },
        },
        { "c", cmd("Format"), { desc = "Format current buffer" } },
        {
            "r",
            function()
                defintion.preview_definition()
            end,
            { desc = "Preview item definition" },
        },
        {
            "l",
            function()
                defintion.show_line_diagnostics()
            end,
            { desc = "Display line diagnostics" },
        },
        {
            "j",
            function()
                defintion.goto_prev()
            end,
            { desc = "Goto previous diagnostic" },
        },
        {
            "k",
            function()
                defintion.goto_next()
            end,
            { desc = "Goto next diagnostic" },
        },
        {
            "p",
            function()
                defintion.goto_prev({
                    severity = vim.diagnostic.severity.ERROR,
                })
            end,
            { desc = "Jump to previous Err." },
        },
        {
            "n",
            function()
                defintion.goto_next({
                    severity = vim.diagnostic.severity.ERROR,
                })
            end,
            { desc = "Jump to next Err." },
        },
        {
            "<Enter>",
            cmd("FormatWrite"),
            { exit = true, desc = "Save & Format current buffer!" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
})

-- Time to define our visual hydra
local visual_code_action = function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    return action.range_code_action()
end

local visual_hint = [[
             Lspsaga (Visual)

  _a_: Code Action
^
                                _q_: Quit
]]

Hydra({
    name = "lspsaga-visual",
    hint = visual_hint,
    config = {
        buffer = bufnr,
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = "v",
    body = "<leader>l",
    heads = {
        {
            "a",
            function()
                visual_code_action()
            end,
            { desc = "Apply visual code action" },
        },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
})
