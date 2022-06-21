require("core.packer")
require("core.settings")
require("core.neovide")

require("keymaps.default")
require("keymaps.which-key")

-- Apply colorscheme
vim.cmd("colorscheme catppuccin")

-- Point nvim to correct sqlite path
vim.g.sqlite_clib_path = vim.env["SQLITE_PATH"]
