require("core")

-- Point nvim to correct sqlite path
vim.g.sqlite_clib_path = vim.env["SQLITE_PATH"]
