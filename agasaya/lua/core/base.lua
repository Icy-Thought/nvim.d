require("core.settings")
require("core.commands")

for _, blt in pairs(Core.disabled_builtins) do
    vim.g["loaded_" .. blt] = 1
end

for k, v in pairs(Core.global_options) do
    vim.go[k] = v
end

for k, v in pairs(Core.options) do
    if type(v) == "table" then
        vim.opt[k]:append(v)
    else
        vim.opt[k] = v
    end
end
