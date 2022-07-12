local create = vim.api.nvim_create_autocmd

-- Limit text-width to 80 chars for documentation formats
create({ "BufRead", "BufNewFile" }, {
    pattern = { "*.md", "*.norg" },
    command = "set textwidth=80",
})
