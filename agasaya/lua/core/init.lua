local core = {}

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

    local map = vim.api.nvim_set_keymap
    map("n", " ", "", { noremap = true })
    map("x", " ", "", { noremap = true })
end

local neovide_config = function()
    if vim.g.neovide then
        vim.o.guifont = "VictorMono Nerd Font:h9:b"

        -- general
        vim.g.neovide_no_idle = true
        vim.g.neovide_transparency = 0.85
        vim.g.neovide_cursor_antialiasing = true
        vim.g.neovide_cursor_trail_length = 0.05
        vim.g.neovide_cursor_animation_length = 0.03

        -- vfx settings
        vim.g.neovide_cursor_vfx_mode = "sonicboom"
        vim.g.neovide_cursor_vfx_opacity = 200.0
        vim.g.neovide_cursor_vfx_particle_density = 5.0
        vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
        vim.g.neovide_cursor_vfx_particle_speed = 20.0
    end
end

core.init = function()
    disable_distribution_plugins()
    disable_providers()

    map_leader()
    neovide_config()

    local packer = require("core.packer")
    packer.ensure_plugins()

    require("core.options")
    require("core.bindings")
    require("core.events")

    packer.load_compile()
end

return core
