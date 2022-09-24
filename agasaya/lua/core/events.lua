local events = {}

local autocmd = vim.api.nvim_create_autocmd

function events.load_autocmds()
    -- Create dir on save if != existent
    autocmd("BufWritePre", {
        pattern = "*",
        callback = function(ctx)
            return vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ":p:h"), "p")
        end,
    })

    -- Auto move to the location of the last edit
    autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
            if
                not vim.fn.expand("%:p"):match(".git")
                and vim.fn.line("'\"") > 1
                and vim.fn.line("'\"") <= vim.fn.line("$")
            then
                vim.cmd("normal! g'\"")
                vim.cmd("normal zz")
            end
        end,
    })

    -- Highlight yanked text
    autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
            vim.highlight.on_yank({
                higroup = "Visual",
                timeout = 200,
            })
        end,
    })

    -- Auto-close Nvim-Tree if last window
    autocmd("BufEnter", {
        pattern = "*",
        callback = function()
            if
                vim.fn.winnr("$") == 1
                and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr()
            then
                vim.cmd("quit")
            end
        end,
    })

    -- Auto change directory
    autocmd("BufEnter", {
        pattern = "*",
        command = "silent! lcd %:p:h",
    })

    -- Force write shada on nvim exit
    autocmd("VimLeave", {
        pattern = "*",
        callback = function()
            if vim.fn.has("nvim-0.7") == 1 then
                vim.cmd("wshada!")
            else
                vim.cmd("wviminfo!")
            end
        end,
    })

    -- Check file status for focused window (more eager than 'autoread')
    autocmd("FocusGained", {
        pattern = "*",
        command = "checktime",
    })

    -- Equalize window dimensions when resizing vim window
    autocmd("VimResized", {
        pattern = "*",
        command = "tabdo wincmd =",
    })

    -- Limit text-width to 80 chars for documentation formats
    autocmd("FileType", {
        pattern = "markdown,norg",
        callback = function()
            if not vim.g.neovide then
                vim.o.textwidth = 80
            else
                vim.o.textwidth = 120
            end
        end,
    })
end

events.load_autocmds()
