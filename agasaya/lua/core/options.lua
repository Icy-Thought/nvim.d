local vim_goptions = function()
    local goptions = {
        background = "dark",
        cmdheight = 1,
        conceallevel = 0,
        fileencoding = "UTF-8",
        helpheight = 12,
        laststatus = 2,
        pumheight = 15,
        showtabline = 2,
        termguicolors = true,
    }

    for k, v in pairs(goptions) do
        vim.go[k] = v
    end
end

local vim_options = function()
    local options = {
        autoread = true,
        backspace = { "indent", "eol", "start" },
        backup = false,
        breakat = [[\ \	;:,!?]],
        breakindentopt = { "shift:2", "min:20" },
        clipboard = "unnamedplus",
        completeopt = { "menuone", "noselect" },
        concealcursor = "niv",
        cursorline = true,
        diffopt = { "filler", "iwhite", "internal", "algorithm:patience" },
        encoding = "UTF-8",
        expandtab = true,
        foldcolumn = "1",
        foldenable = true,
        foldlevel = 99,
        foldlevelstart = 99,
        gdefault = true,
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --hidden --vimgrep --smart-case --",
        hidden = true,
        hlsearch = true,
        ignorecase = true,
        inccommand = "nosplit",
        incsearch = true,
        infercase = true,
        iskeyword = { "-" },
        lazyredraw = true,
        linebreak = true,
        list = true,
        listchars = {
            eol = "",
            extends = "→",
            nbsp = "+",
            precedes = "←",
            space = "⋅",
            tab = "»·",
            trail = "•",
        },
        magic = true,
        mouse = "a",
        number = true,
        numberwidth = 4,
        relativenumber = true,
        scrolloff = 8,
        sessionoptions = { "curdir", "help", "tabpages", "winsize" },
        shada = { "!", "'300", "<50", "@100", "s10", "h" },
        shiftround = true,
        shiftwidth = 4,
        shortmess = { c = true, I = true, s = true },
        showbreak = "↳",
        showmode = false,
        showtabline = 2,
        sidescrolloff = 8,
        signcolumn = "yes",
        smartcase = true,
        smartindent = true,
        softtabstop = 4,
        spell = false,
        splitbelow = true,
        splitright = true,
        startofline = false,
        swapfile = false,
        timeout = true,
        timeoutlen = 500,
        ttimeout = true,
        ttimeoutlen = 0,
        undofile = true,
        updatetime = 150,
        viewoptions = { "folds", "cursor", "curdir", "slash", "unix" },
        whichwrap = "<>[]hl",
        wildignore = {
            ".git",
            ".hg",
            ".svn",
            "*.pyc",
            "*.o",
            "*.out",
            "*.jpg",
            "*.jpeg",
            "*.png",
            "*.gif",
            "*.zip",
            "**/tmp/**",
            "*.DS_Store",
            "**/node_modules/**",
            "**/bower_modules/**",
        },
        wrap = false,
        wrapscan = true,
        writebackup = false,
    }

    for k, v in pairs(options) do
        if type(v) == "table" then
            vim.opt[k]:append(v)
        else
            vim.opt[k] = v
        end
    end
end

local load_options = function()
    vim_options()
    vim_goptions()
end

load_options()
