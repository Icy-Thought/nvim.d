local function fprint(string, ...)
    print(string.format(string, ...))
end

local function plugin_status(status)
    if status ~= nil then
        return "opt/"
    else
        return "start/"
    end
end

local function assert_installed(plugin, branch, status)
    local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
    local plugin_path = vim.fn.stdpath("data")
        .. "/site/pack/packer/"
        .. plugin_status(status)
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

assert_installed("wbthomason/packer.nvim", nil, true)
assert_installed("rktjmp/hotpot.nvim", "nightly")

if pcall(require, "hotpot") then
    require("hotpot").setup({
        modules = { correlate = true },
        provide_require_fennel = true,
    })
    require("core.init")
else
    print("Failed to require Hotpot")
end
