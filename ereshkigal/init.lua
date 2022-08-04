-- A function that applies passes the output of string.format to the print
-- function
---@param string string #template string
local function fprint(string, ...)
    print(string.format(string, ...))
end

-- A function that verifies if the plugin passed as a parameter has been installed,
-- if it isn't it will be installed
---@param plugin string #the plugin, must follow the format `username/repository`
---@param branch string? #the branch of the plugin
local function assert_installed(plugin, branch)
    local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
    local plugin_path = vim.fn.stdpath("data")
        .. "/site/pack/packer/start/"
        .. plugin_name
    if vim.fn.empty(vim.fn.glob(plugin_path)) ~= 0 then
        fprint(
            "Couldn't find '%s'. Cloning a new copy to %s",
            plugin_name,
            plugin_path
        )
        if branch ~= nil then
            vim.fn.system({
                "git",
                "clone",
                "https://github.com/" .. plugin,
                "--branch",
		branch,
                plugin_path,
            })
        else
            vim.fn.system({
                "git",
                "clone",
                "https://github.com/" .. plugin,
                plugin_path,
            })
        end
    end
end

assert_installed("wbthomason/packer.nvim")
assert_installed("rktjmp/hotpot.nvim", "nightly")

if pcall(require, "hotpot") then
    require("hotpot").setup({
        provide_require_fennel = true,
    })
    require("core.init")
else
    print("Failed to require hotpot.")
end
