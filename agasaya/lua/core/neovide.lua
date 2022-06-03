vim.o.guifont = "VictorMono Nerd Font:h9:sb"

-- general
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_trail_length = 0.05
vim.g.neovide_cursor_animation_length = 0.03

-- vfx settings
vim.g.neovide_cursor_vfx_mode = "sonicboom"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_density = 5.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_speed = 20.0

-- Define font-resize behaviour
-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
--
-- function ResizeFont()
-- end
--
-- keymap("n", "<C-+>", "<CMD>lua ResizeFont(1)<CR>", opts)
-- keymap("n", "<C-->", "<CMD>lua ResizeFont(-1)<CR>", opts)
