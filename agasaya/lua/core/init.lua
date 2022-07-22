local disable_distribution_plugins = function()
    local plugins = {
        "2html_plugin",
        "filetupes",
        "fzf",
        "getscript",
        "getscriptPlugin",
        "gtags",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "spellfile_plugin",
        "tar",
        "tarPlugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
    }

    for _, blt in pairs(plugins) do
        vim.g["did_load_" .. blt] = 1
    end
end

local leader_map = function()
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
    vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
    vim.o.guifont = "VictorMono Nerd Font:h9:sb"

    local config = {
        -- general
        neovide_refresh_rate = 120,
        neovide_no_idle = true,
        neovide_cursor_antialiasing = true,
        neovide_cursor_trail_length = 0.05,
        neovide_cursor_animation_length = 0.03,

        -- vfx settings
        neovide_cursor_vfx_mode = "sonicboom",
        neovide_cursor_vfx_opacity = 200.0,
        neovide_cursor_vfx_particle_density = 5.0,
        neovide_cursor_vfx_particle_lifetime = 1.2,
        neovide_cursor_vfx_particle_speed = 20.0,
    }

    for k, v in pairs(config) do
        vim.g[k] = v
    end
end

local load_core = function()
    disable_distribution_plugins()
    leader_map()
    neovide_config()

    require("core.packer")
    require("core.options")
    require("keymap.basics")
    require("core.events")
end

load_core()
