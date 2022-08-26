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

local function disable_providers()
    local providers = {
        "node",
        "perl",
        "python",
        "python3",
        "ruby",
    }

    for _, prv in pairs(providers) do
        vim.g["loaded_" .. prv .. "_provider"] = 0
    end
end

local map_leader = function()
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

local function apply_colorscheme()
    if vim.g.neovide then
        vim.cmd("colorscheme oxocarbon-lua")
    else
        -- Apply proper transparency
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_transparent = true
        vim.g.tokyonight_transparent_sidebar = true

        -- Now we apply our colorscheme
        vim.cmd("colorscheme tokyonight")
    end
end

local load_core = function()
    disable_distribution_plugins()
    map_leader()
    neovide_config()

    require("core.packer")
    require("core.options")
    require("core.keybindings")
    require("core.events")

    apply_colorscheme()
end

load_core()
