local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command =
                table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

local prequire = function(plugin)
    local ok, err = pcall(require, plugin)
    if not ok then
        return nil, err
    end
    return err
end

function autocmd.load_autocmds()
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
                "markdown, norg",
                "set textwidth=80",
            },
        },
    }
    autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
