local wk = require("which-key")

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local maps = {
    ["/"] = { "<CMD>Telescope live_grep<CR>", "Search Project" },
    [" "] = { "<CMD>Telescope find_files<CR>", "Find File" },
    ["d"] = { "<CMD>Alpha<CR>", "Launch Alpha" },
    ["e"] = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
    ["n"] = { "<CMD>nohlsearch<CR>", "No Highlight" },
    b = {
        name = "Buffer",
        ["["] = { "<CMD><CR>", "Previous Buffer" },
        ["]"] = { "<CMD><CR>", "Next Buffer" },
        b = { "<CMD>Telescope buffers<CR>", "Switch Buffer" },
        d = { "<CMD>bd!<CR>", "Close Buffer" },
        O = { "<CMD>%bd|e#<CR>", "Close Buffers Except Current Buf" },
    },
    f = {
        name = "Find",
        f = { "<CMD>Telescope file_browser path=%:p:h<CR>", "Browse Files" },
        r = { "<CMD>Telescope frecency<CR>", "List Frequent File" },
        R = { "<CMD>Telescope oldfiles<CR>", "Open Recent File" },
        s = { "<CMD>w!<CR>", "Save Buffer" },
    },
    g = {
        name = "Git",
        b = { "<CMD>Telescope git_branches<CR>", "Checkout Branch" },
        c = { "<CMD>Telescope git_commits<CR>", "Checkout Commit" },
        d = { "<CMD>Gitsigns diffthis HEAD<CR>", "Diff" },
        g = { "<CMD>Neogit<CR>", "Launch Neogit" },
        j = { "<CMD>Gitsigns next_hunk<CR>", "Next Change" },
        k = { "<CMD>Gitsigns prev_hunk<CR>", "Prev Change" },
        l = { "<CMD>Gitsigns blame_line<CR>", "Blame" },
        o = { "<CMD>Telescope git_status<CR>", "Open Changed File" },
        p = { "<CMD>Gitsigns preview_hunk<CR>", "Preview Changes" },
        r = { "<CMD>Gitsigns reset_hunk<CR>", "Restore File" },
        R = { "<CMD>Gitsigns reset_buffer<CR>", "Reset Buffer" },
        s = { "<CMD>Gitsigns stage_hunk<CR>", "Stage Changes" },
        u = { "<CMD>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
    },
    h = {
        name = "Help",
        c = { "<CMD>Telescope commands<CR>", "List Available Commands" },
        h = { "<CMD>Telescope help_tags<CR>", "Find Help" },
        k = { "<CMD>Telescope keymaps<CR>", "List Keybindings" },
        m = { "<CMD>Telescope man_pages<CR>", "Man Pages" },
        s = { "<CMD>Telescope colorscheme<CR>", "Change Colorscheme" },
    },
    l = {
        name = "LSP",
        a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        d = {
            "<CMD>Telescope lsp_document_diagnostics<CR>",
            "Document Diagnostics",
        },
        w = {
            "<CMD>Telescope lsp_workspace_diagnostics<CR>",
            "Workspace Diagnostics",
        },
        f = { "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
        i = { "<CMD>LspInfo<CR>", "Info" },
        I = { "<CMD>LspInstallInfo<CR>", "Installer Info" },
        j = {
            "<CMD>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<CMD>lua vim.diagnostic.goto_prev()<CR>",
            "Prev Diagnostic",
        },
        l = { "<CMD>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
        q = { "<CMD>lua vim.diagnostic.set_loclist()<CR>", "Quickfix" },
        r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
        s = { "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        S = {
            "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
            "Workspace Symbols",
        },
    },
    m = {
        name = "Markdown Preview",
        p = { "<CMD>MarkdownPreview<CR>", "Preview Markdown" },
        s = { "<CMD>MarkdownPreviewStop<CR>", "Stop Markdown Preview" },
        t = { "<CMD>MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
    },
    p = {
        name = "Project",
        p = { "<CMD>Telescope project<CR>", "Select Project" },
        t = { "<CMD>TodoTelescope<CR>", "List Project Tasks" },
    },
    q = {
        d = { "<CMD>%bd|Alpha<CR>", "Close All Buffers" },
        q = { "<CMD>q!<CR>", "Quit Nvim Without Saving" },
    },
    t = {
        name = "Terminal",
        p = { "<CMD>lua _PYTHON_TOGGLE()<CR>", "Python" },
        f = { "<CMD>ToggleTerm direction=float<CR>", "Float" },
        h = {
            "<CMD>ToggleTerm size=10 direction=horizontal<CR>",
            "Horizontal",
        },
        t = { "<CMD>ToggleTerm direction=tab<CR>", "Tab" },
        v = { "<CMD>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
    },
}

local vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vmaps = {
    ["/"] = {
        "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
        "Comment Linewise",
    },
    ["["] = {
        "<ESC><CMD>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>",
        "Comment Blockwise",
    },
}

wk.register(maps, opts)
wk.register(vmaps, vopts)
