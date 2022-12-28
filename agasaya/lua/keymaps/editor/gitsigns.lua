local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local gitsign_hint = [[
                      Git
    _J_: Next Hunk        _d_: Show Deleted
    _K_: Prev Hunk        _u_: Undo Last Stage
    _s_: Stage Hunk       _/_: Show Base File
    _p_: Preview Hunk     _S_: Stage Buffer
    _b_: Blame Line       _B_: Blame Show Full
  ^
    _<Enter>_: Neogit                _q_: Quit!
]]

local gitsigns = require("gitsigns")

Hydra({
    name = "Git",
    hint = gitsign_hint,
    config = {
        buffer = bufnr,
        color = "pink",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            offset = 3,
            position = "middle",
        },
        on_enter = function()
            vim.cmd("mkview")
            vim.cmd("silent! %foldopen!")
            vim.bo.modifiable = false
            gitsigns.toggle_signs(true)
            gitsigns.toggle_linehl(true)
        end,
        on_exit = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("loadview")
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd("normal zv")
            gitsigns.toggle_signs(false)
            gitsigns.toggle_linehl(false)
            gitsigns.toggle_deleted(false)
        end,
    },
    mode = { "n", "x" },
    body = "<leader>g",
    heads = {
        {
            "J",
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gitsigns.next_hunk()
                end)
                return "<Ignore>"
            end,
            { expr = true, desc = "Next hunk" },
        },
        {
            "K",
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gitsigns.prev_hunk()
                end)
                return "<Ignore>"
            end,
            { expr = true, desc = "Prev hunk" },
        },
        {
            "s",
            ":Gitsigns stage_hunk<CR>",
            { silent = true, desc = "Stage hunk" },
        },
        { "u", gitsigns.undo_stage_hunk, { desc = "Undo last stage" } },
        { "S", gitsigns.stage_buffer, { desc = "Stage buffer" } },
        { "p", gitsigns.preview_hunk, { desc = "Preview hunk" } },
        {
            "d",
            gitsigns.toggle_deleted,
            { nowait = true, desc = "Toggle deleted" },
        },
        { "b", gitsigns.blame_line, { desc = "Blame" } },
        {
            "B",
            function()
                gitsigns.blame_line({ full = true })
            end,
            { desc = "Blame show full" },
        },
        { "/", gitsigns.show, { exit = true, desc = "Show base file" } }, -- show the base of the file
        { "<Enter>", cmd("Neogit"), { exit = true, desc = "Neogit" } },
        { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
})
