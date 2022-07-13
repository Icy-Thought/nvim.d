require("core.packer")
require("core.base")
require("core.neovide")

require("keymaps.default")
require("keymaps.which-key")

-- Point nvim to correct sqlite path
vim.g.sqlite_clib_path = vim.env["SQLITE_PATH"]
