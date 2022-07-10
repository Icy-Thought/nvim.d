local options = {
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

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.iskeyword:append("-")
vim.opt.shortmess:append({ c = true })
vim.opt.diffopt:append({ "internal", "algorithm:patience" })
vim.opt.whichwrap:append("<>[]hl")

-- Limit text-width to 80 chars for documentation formats
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.md", "*.norg" },
    command = "set textwidth=80",
})
