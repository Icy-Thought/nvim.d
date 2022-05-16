-- pick your plugin manager, default [standalone]
local pack = "tangerine" or "packer" or "paq"

local function bootstrap(url)
    local name = url:gsub(".*/", "")
    local path = vim.fn.stdpath([[data]])
        .. "/site/pack/"
        .. pack
        .. "/start/"
        .. name

    if vim.fn.isdirectory(path) == 0 then
        print(name .. ": installing in data dir...")

        vim.fn.system({ "git", "clone", "--depth", "1", url, path })

        vim.cmd([[redraw]])
        print(name .. ": finished installing")
    end
end

bootstrap("https://github.com/udayvir-singh/tangerine.nvim")

-- Ensure loaded plugins has been installed properly
local function plugin_path(plugin)
    return vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. plugin
end

local function plugin_installed(plugin)
    return vim.fn.isdirectory(plugin_path(plugin)) == 1
end

-- Automatically add Packer to Nvim!
vim.api.nvim_command("packadd packer.nvim")

-- Install/setup tangerine for a fennel-based config
if plugin_installed('tangerine.nvim') then
    vim.api.nvim_command("packadd tangerine.nvim")

    require("tangerine").setup({
        target = vim.fn.stdpath [[data]] .. "/tangerine",
      rtpdirs = { "after" },

        compiler = {
                verbose = false,
                hooks = ["onsave", "oninit"]
        }
    })
  end
