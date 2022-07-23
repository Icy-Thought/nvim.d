local events = {}

local autocmd = require("utils.command")

function events.load_autocmds()
    local definitions = {
        packer = {
            -- Auto-update Catppuccin after compiling
            {
                "User",
                "PackerCompileDone",
                "CatppuccinCompile",
            },
        },
        buffer = {
            -- Auto move to the location of the last edit
            {
                "BufReadPost",
                "*",
                [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
            },
            -- Auto-close Nvim-Tree if last window
            {
                "BufEnter",
                "*",
                [[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
            },
            -- Auto change directory
            { "BufEnter", "*", "silent! lcd %:p:h" },
        },
        window = {
            -- Force write shada on nvim exit
            {
                "VimLeave",
                "*",
                [[if has('nvim') | wshada! | else | wviminfo! | endif]],
            },
            -- Check file status for focused window (more eager than 'autoread')
            { "FocusGained", "* checktime" },
            -- Equalize window dimensions when resizing vim window
            { "VimResized", "*", [[tabdo wincmd =]] },
        },
        filetype = {
            -- Limit text-width to 80 chars for documentation formats
            {
                "FileType",
                "markdown,norg",
                "set textwidth=80",
            },
        },
    }
    autocmd.nvim_create_augroups(definitions)
end

events.load_autocmds()
