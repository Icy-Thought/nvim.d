local vim_goptions = function()
    local goptions = {
        background = "dark",
        cmdheight = 1,
        conceallevel = 3,
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
        autowrite = true,
        backspace = { "indent", "eol", "start" },
        backup = false,
        breakat = [[\ \	;:,!?]],
        breakindentopt = { "shift:2", "min:20" },
        completeopt = { "menuone", "noselect" },
        concealcursor = "niv",
        confirm = true,
        cursorline = true,
        diffopt = { "filler", "iwhite", "internal", "algorithm:patience" },
        encoding = "UTF-8",
        expandtab = true,
        foldcolumn = "1",
        foldenable = true,
        foldlevel = 99,
        foldlevelstart = 99,
        grepprg = "rg --vimgrep",
        grepformat = "%f:%l:%c:%m",
        hidden = true,
        hlsearch = true,
        ignorecase = true,
        inccommand = "nosplit",
        incsearch = true,
        infercase = true,
        joinspaces = false,
        linebreak = true,
        list = true,
        listchars = {
            -- eol = "↴",
            extends = "▸",
            nbsp = "◇",
            precedes = "◂",
            -- lead  = "⋅",
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
        shortmess = "filnxtToOFWIcC",
        showbreak = "↳ ",
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
        splitkeep = "screen",
        startofline = false,
        swapfile = false,
        timeout = true,
        timeoutlen = 400,
        ttimeout = true,
        ttimeoutlen = 0,
        undofile = true,
        undolevels = 10000,
        updatetime = 50,
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
