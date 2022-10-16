vim.o.guifont = "VictorMono Nerd Font:h9:b"

-- general
local options = {
    neovide_confirm_quit = true,
    neovide_no_idle = true,
    neovide_transparency = 0.85,

    neovide_input_use_logo = true,
    neovide_remember_window_size = false,
    neovide_scale_factor = 0,

    neovide_cursor_antialiasing = true,
    neovide_hide_mouse_when_typing = true,
    neovide_font_subpixel_antialiasing = 1,

    -- vfx settings
    neovide_cursor_vfx_mode = "sonicboom",
    neovide_cursor_vfx_opacity = 200.0,
}

for k, v in pairs(options) do
    vim.g[k] = v
end

-- Disable animations outside buffers
vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
        vim.g.neovide_scroll_animation_length = 0
        vim.g.neovide_cursor_animation_length = 0
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.defer_fn(function()
            vim.g.neovide_scroll_animation_length = 0.3
            vim.g.neovide_cursor_animation_length = 0.04
        end, 200)
    end,
})
