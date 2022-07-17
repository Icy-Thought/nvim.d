local utils = require("utils")
local action = require("lspsaga.codeaction")
local diagnostic = require("lspsaga.diagnostic")

-- General LSP mappings
utils.nnoremap(
    "<leader>lf",
    "<CMD>lua vim.lsp.buf.format({ async = true })<CR>",
    { desc = "Format Code" }
)

-- Find word definition and reference
utils.nnoremap(
    "gh",
    "<CMD>Lspsaga lsp_finder<CR>",
    { desc = "Lookup code definition + reference" }
)

-- Code action
utils.nnoremap(
    "<leader>ca",
    action.code_action,
    { desc = "Code action (cursor)" }
)

utils.vnoremap("<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end, { desc = "Code action (selection)" })

-- Hover Doc
utils.nmap(
    "K",
    require("lspsaga.hover").render_hover_doc,
    { desc = "Show hover-doc" }
)

-- Scroll down hover doc or scroll in definition preview
utils.nmap("<C-f>", function()
    action.smart_scroll_with_saga(1)
end, { desc = "Scroll hover-doc down | def. preview" })

-- Scroll up hover doc
utils.nmap("<C-b>", function()
    action.smart_scroll_with_saga(-1)
end, { desc = "Scroll hover-doc up" })

-- LSP-signature
utils.nnoremap(
    "gs",
    require("lspsaga.signaturehelp").signature_help,
    { desc = "Show signature help" }
)

-- LSP-rename
utils.nnoremap(
    "gr",
    require("lspsaga.rename").lsp_rename,
    { desc = "Rename definition" }
)

-- Preview definition
utils.nnoremap(
    "gd",
    require("lspsaga.definition").preview_definition,
    { desc = "Preview definition" }
)

-- Jump and show diagnostics
utils.nnoremap(
    "<leader>cd",
    diagnostic.show_line_diagnostics,
    { desc = "Show line diagnostic" }
)

-- Jump diagnostic
utils.nnoremap(
    "[e",
    diagnostic.goto_prev,
    { desc = "Goto previous diagnostic" }
)
utils.nnoremap("]e", diagnostic.goto_next, { desc = "Goto next diagnostic" })

-- or jump to error
utils.nnoremap("[E", function()
    diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Goto previous Err" })

utils.nnoremap("]E", function()
    diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Goto next Err" })
