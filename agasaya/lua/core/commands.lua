local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local prequire = function(plugin)
    local ok, err = pcall(require, plugin)
    if not ok then
        return nil, err
    end
    return err
end

-- Limit text-width to 80 chars for documentation formats
autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.md", "*.norg" },
    command = "set textwidth=80",
})

-- Launch Neogit from current buffer
usercmd("NeogitCB", function()
    local neogit = prequire("neogit")
    neogit.open({ cwd = vim.fn.expand("%:p:h") })
end, { nargs = 0 })
