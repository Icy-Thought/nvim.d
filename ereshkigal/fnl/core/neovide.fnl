(import-macros {: set!} :macros.option)

;; Apply GUI-font to Neovide
(set! guifont "Liga SFMono Nerd Font:h15")

;; general
(tset vim.g :neovide_refresh_rate 120)
(tset vim.g :neovide_no_idle true)
(tset vim.g :neovide_cursor_antialiasing true)
(tset vim.g :neovide_cursor_trail_length 0.05)
(tset vim.g :neovide_cursor_animation_length 0.03)

;; vfx settings
(tset vim.g :neovide_cursor_vfx_mode :sonicboom)
(tset vim.g :neovide_cursor_vfx_opacity 200)
(tset vim.g :neovide_cursor_vfx_particle_density 5)
(tset vim.g :neovide_cursor_vfx_particle_lifetime 1.2)
(tset vim.g :neovide_cursor_vfx_particle_speed 20)

