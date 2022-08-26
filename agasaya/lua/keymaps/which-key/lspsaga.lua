local bind = require("utils.keymap")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- Easier access to LSP-Saga lib
local action = require("lspsaga.codeaction")
local diagnostic = require("lspsaga.diagnostic")
local definition = require("lspsaga.definition")
local hover = require("lspsaga.hover")
local rename = require("lspsaga.rename")
local signature = require("lspsaga.signaturehelp")

local visual_code_action = function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end

local saga_smart_scroll = function(direction)
    if direction == "up" then
        return require("lspsaga.action").smart_scroll_with_saga(1)
    elseif direction == "down" then
        return require("lspsaga.action").smart_scroll_with_saga(-1)
    end
end

local saga_err_jump = function(direction)
    local severity = vim.diagnostic.severity.ERROR
    if direction == "prev" then
        return diagnostic.goto_prev({ severity = severity })
    elseif direction == "next" then
        return diagnostic.goto_next({ severity = severity })
    end
end

local def_lspsaga = {
    ["n|<leader>lf"] = map_cr("FormatWrite")
        :with_noremap()
        :with_desc("Format Code"),

    ["n|gh"] = map_cr("Lspsaga lsp_finder")
        :with_noremap()
        :with_desc("Lookup code definition + reference"),

    ["n|<leader>ca"] = map_cr(action.code_action)
        :with_noremap()
        :with_desc("Code action (cursor)"),

    ["v|<leader>ca"] = map_cr(visual_code_action())
        :with_noremap()
        :with_desc("Code action (selection)"),

    ["n|K"] = map_cr(hover.render_hover_doc):with_desc(
        "Bring forward Hover-DOC"
    ),

    ["n|<C-b>"] = map_cr(saga_smart_scroll("up")):with_desc(
        "Scroll Hover-DOC up"
    ),

    ["n|<C-f>"] = map_cr(saga_smart_scroll("down")):with_desc(
        "Scroll Hover-DOC down | def. preview"
    ),

    ["n|gs"] = map_cr(signature.signature_help)
        :with_noremap()
        :with_desc("Show signature help"),

    ["n|gr"] = map_cr(rename.lsp_rename)
        :with_noremap()
        :with_desc("Rename selected def."),

    ["n|gd"] = map_cr(definition.preview_definition)
        :with_noremap()
        :with_desc("Preview item def."),

    ["n|<leader>cd"] = map_cr(diagnostic.show_line_diagnostics)
        :with_noremap()
        :with_desc("Show line diagnostics"),

    ["n|[e"] = map_cr(diagnostic.goto_prev)
        :with_noremap()
        :with_desc("Goto previous diagnostic"),

    ["n|]e"] = map_cr(diagnostic.goto_next)
        :with_noremap()
        :with_desc("Goto next diagnostic"),

    ["n|[E"] = map_cr(saga_err_jump("prev"))
        :with_noremap()
        :with_desc("Jump to previous Err"),

    ["n|]E"] = map_cr(saga_err_jump("next"))
        :with_noremap()
        :with_desc("Jump to next Err"),
}

bind.nvim_load_mapping(def_lspsaga)
