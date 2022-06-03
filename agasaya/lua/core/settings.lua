local opts = {
    autoread = true,
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 2,
    completeopt = { "menuone", "noselect" },
    conceallevel = 1,
    cursorline = true,
    expandtab = true,
    fileencoding = "utf-8",
    gdefault = true,
    hlsearch = true,
    ignorecase = true,
    lazyredraw = true,
    magic = true,
    mouse = "a",
    number = true,
    numberwidth = 4,
    pumheight = 10,
    relativenumber = true,
    scrolloff = 8,
    shiftwidth = 4,
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
    swapfile = false,
    termguicolors = true,
    timeoutlen = 100,
    undofile = true,
    updatetime = 300,
    wrap = false,
    writebackup = false,
}

vim.opt.shortmess:append({ c = true })
vim.opt.diffopt:append({ "internal", "algorithm:patience" })

for k, v in pairs(opts) do
    vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
vim.cmd([[au BufRead,BufNewFile *.md setlocal textwidth=80 fo+=t]])
vim.cmd([[set iskeyword+=-]])
