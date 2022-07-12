require("core.settings")
require("core.autocmds")

for _, blt in pairs(Config.disabled_builtins) do
    vim.g["loaded_" .. blt] = 1
end

for k, v in pairs(Config.options) do
    if type(v) == "table" then
        vim.opt[k]:append(v)
    else
        vim.opt[k] = v
    end
end
